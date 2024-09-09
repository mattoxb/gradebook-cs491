#!/usr/bin/env python3

"""
This module provides the database class and all functions to handle scores.

There are two functions:
- load-scores - This assumes a prairielearn CSV.  The column headers that match
                scores will be taken as score lists.
- show-scores
   - given a netid, show all the scores on record for that netid
   - given a slug, show all the scores for that assignment
"""

import csv
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, Float, update
import pandas as pd
import re

from gradebook.db import session, Base
from gradebook.parser import subparsers

from gradebook.assignments import Assignment
from gradebook.students import Student, get_one_netid, match_coursera_to_roster

from gradebook.config import COURSERA_MAPPING

def isClose(x1,x2,n=2):
    "Compare two floating point numbers to n digits past the decimal."

    p = 10 ** n
    return int(x1*p) == int(x2*p)

class Score(Base):
    "This class handles the ORM mapping for scores."
    __tablename__ = 'scores'

    id = Column(Integer, primary_key=True)
    student_id =  Column(Integer, ForeignKey('students.id'))
    assignment_id = Column(Integer, ForeignKey('assignments.id'))
    status = Column(String(1))
    score = Column(Float)

    __table_args__ = (UniqueConstraint('student_id','assignment_id'),)

def coursera_scores(params):
    """Load scores from a Coursera CSV file.  You need to define COURSERA_MAPPINGS in the config
    file. You also need to define COURSERA_OVERRIDES since it will put manual overrides in a separate
    column. If you don't want to load a score (e.g., the final exam to perform retcons) just leave
    the mapping out."""

    assignments = {}
    for asn in session.query(Assignment).all():
        assignments[asn.slug] = asn

    changes = 0

    with open(params['fname'], newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            q = session.query(Student).filter(Student.uin == row['External Student ID'])

            if q.count() == 0:  # no such student
                continue
            student = q.first()

            scores = {}
            for s in session.query(Score).filter(Score.student_id == student.id).all():
                scores[s.assignment_id] = s

            for aslug in assignments.keys():
                if aslug in COURSERA_MAPPING:
                    (normal,override) = COURSERA_MAPPING[aslug]
                    this_assignment = assignments[aslug]

                    new_score = None
                    if row[override] != '':
                        new_score = float(row[override]) * 100 / this_assignment.max_points
                    elif row[normal] != '':
                        new_score = float(row[normal]) * 100 / this_assignment.max_points

                    the_score = scores[this_assignment.id]

                    # No score, score pending/missing
                    if new_score is None and the_score.status in ['p','m']:
                        continue

                    # Score is excused
                    if the_score.status == 'x':
                        continue

                    # Score didn't change
                    if new_score is not None and isClose(new_score,the_score.score):
                        continue

                    # Score exists, but is missing now.
                    if new_score is None and the_score.status =='g':
                        the_score.status = 'm'
                        the_score.score = 0
                    else:
                        the_score.status = 'g'
                        the_score.score = float(new_score)

                    session.add(the_score)
                    changes += 1

        print(f"{changes} scores updated.")
        session.commit()

def none_max(x1,x2):
    "Returns the max, but handles None."

    if x1 is None:
        return x2
    if x2 is None:
        return x1
    return max(x1,x2)

def max_key(d,k,x2):
    if k not in d:
        d[k] = None
    d[k] = none_max(d[k],x2)
    
def none_sum(xx):
    "Add integers in a list, some of which may be None."
    sum = 0
    for x in xx:
        if x is not None:
            sum += x
    return sum

def load_submissions_scores(params):
    """Loads scores from a Prairielearn all_submissions file.  Enforces due date and percentages
    for late submissions.  Hopefully we don't need this next summer."""

    slug = params['assignment']

    assignment = session.query(Assignment).filter(Assignment.slug == slug).first()

    due_dates = {'mp-1': '2024-05-26T23:59:59',
                 'mp-2': '2024-06-02T23:59:59',
                 'mp-3': '2024-06-16T23:59:59',
                 'mp-4': '2024-07-07T23:59:59',
                 'mp-5': '2024-07-14T23:59:59',
                 'mp-6': '2024-07-28T23:59:59'}
    late_dates = {'mp-1': '2024-06-02T23:59:59',
                  'mp-2': '2024-06-09T23:59:59',
                  'mp-3': '2024-06-23T23:59:59',
                  'mp-4': '2024-07-14T23:59:59',
                  'mp-5': '2024-07-21T23:59:59',
                  'mp-6': '2024-08-04T23:59:59'}

    mp1a = None
    mp1b = None
    is_late = False

    out_file = open('output-files/' + slug + '.txt','w')

    with open(params['fname'], newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        last_student = None
        on_time = {}
        late = {}

        seen = {}

        for row in reader:
            if row['Role'] != 'Student':
                continue

            # This code should be factored since it is duplicated

            if row['UIN'] != '':  # UIUC Entry
                if row['UIN'] in seen:
                    student = seen[row['UIN']]
                else:
                    q = session.query(Student).filter(Student.uin == row['UIN'])
                    if q.count() == 0:
                        # print(f"Student UIN {row['UIN']} name {row['Name']} not found.")
                        continue
                    student = q.first()
                    seen[row['UIN']] = student
            else: # Coursera Entry
                if row['UID'] in seen:
                    student= seen[row['UID']]
                else:
                    student = match_coursera_to_roster(row['UID'],row['Name'])
                    if student is None:
                        # print(f"Coursera Student {row['Name']} not found.\nUID: {row['UID']}")
                        continue
                    seen[row['UID']] = student

            if student.status != 'r': # skip students who have dropped
                continue
            
            # If we have switched students, we need to update their scores.

            if last_student != student:
                if last_student is not None:
                    best_on_time = none_sum(on_time.values()) / assignment.max_points * 100
                    best_late = none_sum(late.values()) / assignment.max_points * 80
                    best = max(best_on_time,best_late)
                    out_file.write(f'{last_student.name} {best}\n')
                    # Set score here
                    the_score = session.query(Score).filter(Score.student_id == last_student.id,
                                                            Score.assignment_id == assignment.id).first()
                    if the_score is None:
                        print(f"Score doesn't exist for {last_student.name}!")
                    the_score.status = 'g'
                    the_score.score = best
                    session.add(the_score)

                last_student = student
                on_time = {}
                late = {}

            if row['Submission date'] <= due_dates[slug] and row['Score'] != '':
                out_file.write(f"On time submission {row['Submission date']} of {row['Question']}: {row['Score']} points.\n")
                max_key(on_time,row['Question'], float(row['Score']) * float(row['Max points']))
                max_key(late,row['Question'], float(row['Score']) * float(row['Max points']))
            elif row['Submission date'] <= late_dates[slug] and row['Score'] != '':
                out_file.write(f"Late submission {row['Submission date']} of {row['Question']}: {row['Score']} points.\n")
                max_key(late,row['Question'], float(row['Score']) * float(row['Max points']))

        # Loop is done, update last student
        best_on_time = none_sum(on_time.values()) / assignment.max_points * 100
        best_late = none_sum(late.values()) / assignment.max_points * 80
        best = max(best_on_time,best_late)
        out_file.write(f'{last_student.name} {best}\n')
        the_score = session.query(Score).filter(Score.student_id == last_student.id,
                                                Score.assignment_id == assignment.id).first()
        the_score.status = 'g'
        the_score.score = best
        session.add(the_score)
    
        out_file.close()
        session.commit()
 
def update_score(score,new_value):
    """Given a score ORM and a new value, update the score.
    Does not create the score if it doesn't exist."""

    if score is None:
        return

    if new_value == 'NONE' or new_value == 'm':
        score.status = 'm'
        score.score = 0
    elif new_value == 'x':
        score.status = 'x'
    else:
        score.status = 'g'
        score.score = float(new_value)

    session.add(score)

def load_attendance(params):
    months = { '08':'aug',
               '09':'sep',
               '10':'oct',
               '11':'nov',
               '12':'dec' }
    
    with open('score-files/attendance.csv') as file:
        reader = csv.DictReader(file)
        for row in reader:
            uin = row['uin']
            q = session.query(Student).filter(Student.uin == uin)
            if q.count() == 0:
                # print(f"Student UIN {row['UIN']} name {row['Name']} not found.")
                continue
            student = q.first()
            if student.status == 'd':
                continue

            dates = row['comment']
            for d in re.findall(r'[0-9]+/[0-9]+',dates):
                mon,day = d.split('/')
                slug = f"{months[mon]}-{int(day):02d}"
                
                result = session.query(Score,Assignment).filter(Score.student_id == student.id,
                                                                Assignment.slug == slug,
                                                                Score.assignment_id == Assignment.id).first()
                
                if result is None:
                    print(f"Student {student.name} / {student.netid} does not have a score entry for {slug}.")
                else:
                    score = result[0]
                    score.score = 100
                    score.status = 'g'
                    session.add(score)
        session.commit()

def load_scores(params):
    """Load the scores from a file that has a student and one or more scores.  Use should provide a
    mapping from the column names to the netid/uin and the assignment slugs."""

    column_map = {}
    aids = {}
    seen = {}

    for asn in session.query(Assignment).all():
        aids[asn.slug] = asn.id
        column_map[asn.slug] = asn.slug

    for i in range(1,13):
        column_map[f'Quiz {i}'] = f'quiz-{i}'

    with open(params['fname'], newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        headers = reader.fieldnames
        has_slug_column = 'slug' in headers

        for row in reader:

            if 'netid' in row: # manual entry
                q = session.query(Student).filter(Student.netid == row['netid'].split('@')[0])
                if q.count() == 0:  # no such student
                    continue
                student = q.first()
            elif row['UIN'] != '':  # UIUC Entry
                if row['UIN'] in seen:
                    student = seen[row['UIN']]
                else:
                    q = session.query(Student).filter(Student.uin == row['UIN'])
                    if q.count() == 0:
                        # print(f"Student UIN {row['UIN']} name {row['Name']} not found.")
                        continue
                    student = q.first()
                    seen[row['UIN']] = student
            else: # Coursera Entry
                if row['UID'] in seen:
                    student= seen[row['UID']]
                else:
                    student = match_coursera_to_roster(row['UID'])
                    if student is None:
                        # print(f"Coursera Student {row['Name']} not found.\nUID: {row['UID']}")
                        continue
                    seen[row['UID']] = student


            scores = {}
            for s in session.query(Score).filter(Score.student_id == student.id).all():
                scores[s.assignment_id] = s

            if has_slug_column:
                slug = row['slug']

                if aids[slug] in scores.keys():
                    news = scores[aids[slug]]
                else:
                    news = Score()
                    news.student_id = student.id
                    news.assignment_id = aids[slug]

                update_score(news,row['score'])

            else:

                for column in column_map.keys():
                    if column in row.keys():
                        slug = column_map[column]

                        if aids[slug] in scores.keys():
                            news = scores[aids[slug]]
                        else:
                            news = Score()
                            news.student_id = student.id
                            news.assignment_id = aids[slug]

                        update_score(news,row[column])

        session.commit()

def print_scores(params):
    "Print the scores as a pandas dataframe."

    if params['netid'] == 'x':
        params['netid'] = get_one_netid(params)

    q = session.query(Assignment, Score, Student).filter(Assignment.id == Score.assignment_id,
                                                         Score.student_id == Student.id,
                                                         Student.netid == params['netid'])
    # Remove the '_sa_instance_state' key that SQLAlchemy adds to each row
    result = []
    for (assignment,score,_) in q.all():
        h = {"Slug": assignment.slug,
             "Title": assignment.title,
             "Status": score.status,
             "Score": score.status in ['m','g'] and score.score or ''}
        result.append(h)

        # Create a DataFrame
    df = pd.DataFrame(result)

    pd.set_option('display.max_rows', None)
#    out = df[['id','netid','uin','name','section','credit','year','major']].to_string(index=False)

    print(df)

def create_pending_scores(new_asns):
    "Given a list of assignments, create a pending score in the database for all current students."

    ids = []
    for stu in session.query(Student).filter(Student.status == 'r').all():
        ids.append(stu.id)

    print(f'{len(ids)} students, {len(new_asns)} new scores')

    # Get the new assignments.

    for asn in session.query(Assignment).filter(Assignment.slug.in_(new_asns)).all():
        print(asn.slug)
        for student in ids:
            s = Score()
            s.student_id = student
            s.assignment_id = asn.id
            s.status = 'p'
            s.score = 0
            session.add(s)

    session.commit()

def get_students_by_score_status(params):
    "Get a list of students with a specific score status."

    assignment = session.query(Assignment).where(Assignment.slug == params['assignment']).first()
    if assignment is None:
        print("Assignment not found.")
        return

    query = session.query(Student,Score).where(Score.status == params['status'],
                                               Score.assignment_id == assignment.id,
                                               Student.id == Score.student_id)

    if params['email']:
        for (student,_) in query.all():
            print(student.email)
    elif params['netid']:
        for (student,_) in query.all():
            print(student.netid)
    else:
        for (student,score) in query.all():
            print(f'{student.name} {student.netid} {score.status} {score.score}')


def make_missing_scores(params):
    "Change all the pending scores to missing for a given assignment."

    ids = []
    for stu in session.query(Student).filter(Student.status == 'r').all():
        ids.append(stu.id)

    assignment = session.query(Assignment).where(Assignment.slug == params['assignment']).first()
    if assignment is None:
        print("Assignment not found.")
        return

    statement = update(Score).where(Score.status == 'p',
                                    Score.assignment_id == assignment.id).values(status='m')

    session.execute(statement)
    session.commit()

# --------------------------------------------------------------------------------
# Category Parser
# --------------------------------------------------------------------------------

scores_parser = subparsers.add_parser('scores', aliases=['sc','sco'],
                                        help='Scores commands')
scores_parser.set_defaults(func=lambda x: scores_parser.print_help())

subs = scores_parser.add_subparsers(title='scores subcommands', help='scores subcommand help')

load_parser = subs.add_parser('load', aliases=['l','load'],
                                  help='Load / update the scores.')
load_parser.add_argument('fname', type=str,
                         help='The CSV file with the scores info. \
                         Column header(s) contains the slug(s).')
load_parser.set_defaults(func=load_scores)

load_submissions_parser = subs.add_parser('load-submissions', aliases=['ls'],
                                  help='Load / update the scores.')
load_submissions_parser.add_argument('assignment', type=str, help = 'The asssignment slug.')
load_submissions_parser.add_argument('fname', type=str,
                         help='The CSV file with the scores info. \
                         Column header(s) contains the slug(s).')
load_submissions_parser.set_defaults(func=load_submissions_scores)

attendance_parser = subs.add_parser('attendance', aliases=['a','att'],
                                  help='Load scores from an attendance app.')
attendance_parser.add_argument('fname', type=str,
                             help='The CSV file with the scores info.')
attendance_parser.set_defaults(func=load_attendance)

coursera_parser = subs.add_parser('coursera', aliases=['c','coursera'],
                                  help='Load scores from a Coursera csv.')
coursera_parser.add_argument('fname', type=str,
                             help='The CSV file with the scores info. \
                             Column header contains the slug(s).')
coursera_parser.set_defaults(func=coursera_scores)

print_parser = subs.add_parser('print', aliases=['p'], help='Print the scores.')
print_parser.add_argument('--netid', '-n', type=str,
                          help='Print scores for a given netid.')
print_parser.add_argument('--assignment', '-a', type=str,
                          help='Print scores for a given assignment.')
print_parser.set_defaults(func=print_scores)

make_missing_parser = subs.add_parser('missing', aliases=['m','miss'], help='Change pending scores to missing.')
make_missing_parser.add_argument('assignment', type=str,
                          help='Make pending scores to be missing.')
make_missing_parser.set_defaults(func=make_missing_scores)

get_status_parser = subs.add_parser('status', aliases=['st'], help='Get students with scores of a certain status.')
get_status_parser.add_argument('assignment', type=str,
                          help='The assignment in question.')
get_status_parser.add_argument('--pending', '-p', dest='status', action='store_const', const='p', help='Get pending scores.')
get_status_parser.add_argument('--missing', '-m', dest='status', action='store_const', const='m', help='Get missing scores.')
get_status_parser.add_argument('--excused', '-x', dest='status', action='store_const', const='x', help='Get excused scores.')
get_status_parser.add_argument('--graded',  '-g', dest='status', action='store_const', const='g', help='Get graded scores.')

get_status_parser.add_argument('--netid', '-n', action='store_true', help='Just return the list of netids.')
get_status_parser.add_argument('--email', '-e', action='store_true', help='Just return the list of emails.')
get_status_parser.set_defaults(func=get_students_by_score_status)
