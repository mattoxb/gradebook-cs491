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
from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, Float
import pandas as pd

from gradebook.db import session, Base
from gradebook.parser import subparsers

from gradebook.assignments import Assignment
from gradebook.students import Student

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

    __table__args__ = UniqueConstraint('student_id','assignment_id')

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

                    # Score exists, but has not changed
                    if isClose(new_score,the_score.score):
                        continue

                    # Score is updated.

                    the_score.status = 'g'
                    the_score.score = float(new_score)

                    session.add(the_score)
                    changes += 1

        print(f"{changes} scores updated.")
        session.commit()


def load_scores(params):
    """Load the scores from a file that has a student and one or more scores.  Use should provide a
    mapping from the column names to the netid/uin and the assignment slugs."""

    aids = {}
    for asn in session.query(Assignment).all():
        aids[asn.slug] = asn.id
    print(aids)

    with open(params['fname'], newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            q = session.query(Student).filter(Student.netid == row['netid'].split('@')[0])

            if q.count() == 0:  # no such student
                continue
            student = q.first()

            scores = {}
            for s in session.query(Score).filter(Score.student_id == student.id).all():
                scores[s.assignment_id] = s

            for aslug in aids.keys():
                if aslug in row.keys():

                    if aids[aslug] in scores.keys():
                        news = scores[aids[aslug]]
                    else:
                        news = Score()
                        news.student_id = student.id
                        news.assignment_id = aids[aslug]

                    if row[aslug] == 'NONE':
                        news.status = 'm'
                        news.score = 0
                    else:
                        news.status = 'g'
                        news.score = float(row[aslug])

                    session.add(news)
        session.commit()

def print_scores(params):
    "Print the scores as a pandas dataframe."

    q = session.query(Assignment, Score, Student).filter(Assignment.id == Score.assignment_id,
                                                         Score.student_id == Student.id,
                                                         Student.netid == params['netid'])
    # Remove the '_sa_instance_state' key that SQLAlchemy adds to each row
    result = []
    for (assignment,score,student) in q.all():
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


# --------------------------------------------------------------------------------
# Category Parser
# --------------------------------------------------------------------------------

scores_parser = subparsers.add_parser('scores', aliases=['sc','sco'],
                                        help='Scores commands')
scores_parser.set_defaults(func=lambda x: scores_parser.print_help())

subs = scores_parser.add_subparsers(title='scores subcommands', help='scores subcommand help')

load_parser = subs.add_parser('load', aliases=['l','load'],
                                  help='Load / update the scores.')
load_parser.add_argument('--fname', '-f', default='scores.csv', type=str,
                             help='The CSV file with the scores info. \
                             Column header(s) contains the slug(s).')
load_parser.set_defaults(func=load_scores)

coursera_parser = subs.add_parser('coursera', aliases=['c','coursera'],
                                  help='Load scores from a Coursera csv.')
coursera_parser.add_argument('fname', default='scores.csv', type=str,
                             help='The CSV file with the scores info. \
                             Column header contains the slug(s).')
coursera_parser.set_defaults(func=coursera_scores)

print_parser = subs.add_parser('print', aliases=['p'], help='Print the scores.')
print_parser.add_argument('--netid', '-n', type=str,
                          help='Print scores for a given netid.')
print_parser.add_argument('--assignment', '-a', type=str,
                          help='Print scores for a given assignment.')
print_parser.set_defaults(func=print_scores)
