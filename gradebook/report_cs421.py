#!/usr/bin/env python3


"""
This module provides grade reports for CS 421.
"""

import pandas as pd

import datetime

from gradebook.db import session
from gradebook.parser import subparsers
from gradebook.categories import Category
from gradebook.scores import Score
from gradebook.students import Student
from gradebook.assignments import Assignment
from gradebook.exam_zones import Zone

scale = [(97,'A+'), (93,'A'), (90,'A-'),
         (87,'B+'), (83,'B'), (80,'B-'),
         (77,'C+'), (73,'C'), (70,'C-'),
         (67,'D+'), (63,'D'), (60,'D-'),
         (-1,'F')]

def curve(score):
    for k,v in scale:
        if score >= k:
            return v
    return "None"

def getCategoryScores(student,category):
    return session.query(Assignment,Score,Category) \
                        .filter(Score.student_id == student.id)\
                        .filter(Score.assignment_id == Assignment.id) \
                        .filter(Category.slug == category) \
                        .filter(Assignment.category_id == Category.id) \
                        .order_by(Assignment.order).all()

    
def dropNLowest(scores,n):
    """Drop the n lowest scores in list scores.  Returns resulting average.
    
    If |scores| = 0, returns None.
    If |scores| < n, drops |scores|-1.
    """

    def dropping_string(n):
        if n == 1:
            return "lowest score"
        else:
            return f"{n} lowest scores"

    scores.sort()

    if len(scores) == 0:
        return {}
    if len(scores) < n:
        print(f"Dropping {dropping_string(len(scores)-1)}. " +
        "(Need > {n} scores before all drops can occur.):")
        n = len(scores)-1
    else:
        print(f"Dropping {dropping_string(n)}:")

    print("  ",end='')
    drops = scores[0:n]
    for d in drops:
        print(f"{d:.2f} ",end='')
    print()
    average = sum(scores[n:])/(len(scores)-n)

    return average

def show(date):
    "Print the date in a nicely formatted way."
    return date.strftime("%Y-%m-%d %H:%M:%S")

def report_exam(exam,exam_weight,student,final_zones,final_scores):

    print(f"## {exam.title} - Worth {exam_weight / 2:.2f}\n")

    total = 0
    data = []
    final_taken = False

    for score in final_scores.values():
        if score.status == 'g':
            final_taken = True

    num_zones = 0

    for zone,_,score in session.query(Zone,Assignment,Score). \
            filter(Zone.exam_id == exam.id,
                   Zone.assignment_id == Assignment.id,
                   Score.assignment_id == Assignment.id,
                   Score.student_id == student.id).order_by(Zone.order).all():

        num_zones += 1
        score_percent = score.score / zone.max_points * 100

        if final_taken:
            final_slug = zone.slug.replace(exam.slug,'final')
            final_score = final_scores[final_slug]
            if final_score.status == 'g':
                final_percent = final_score.score / final_zones[final_slug].max_points * 100

                if final_percent >= score_percent:
                    new_percent = final_percent
                else:
                    new_percent = (final_percent + score_percent) / 2

                data.append({'Zone':zone.title, 'Score %': f'{score_percent:.2f}',
                             'Final': f'{final_percent:.2f}', 'New Score %': f'{new_percent:.2f}'})
                total = total + new_percent
            else:
                data.append({'Zone':zone.title, 'Score %': f'{score_percent:.2f}',
                             'Final': '', 'New Score %': ''})
                total = total + score_percent
        else:
            data.append({'Zone':zone.title, 'Score %': f'{score_percent:.2f}'})
            total = total + score_percent

    if data == []:
        print(" Scores Pending")
        return None

    exam_score = total / num_zones

    print(pd.DataFrame(data).to_string(index=False))

    print(f"\n - {exam.title} Score %: {exam_score:.2f}%\n\n")

    return exam_score

   
def report_netid(params):
    "Generate a report for a given netid.  Returns the letter grade."

    netid = params['netid']
    student = session.query(Student).filter(Student.netid == netid).first()

    if student.credit == 3:
        quiz_weight = 12.5
        mp_weight = 37.5
        exam_weight = 50
        project_weight = 0
    else:
        quiz_weight = 10.0
        mp_weight = 30.0
        exam_weight = 40
        project_weight = 20

    # Check now to save some grief later
    assert quiz_weight + mp_weight + exam_weight + project_weight == 100

    if student is None:
        print("Netid not found.")
        return None

    print(f'# Grade Report for {student.netid}\n')
    print(f'Generated {show(datetime.datetime.now())}\n\n')

    # ------------------------------
    # Quizzes
    # ------------------------------

    print(f"## Quizzes - Worth {quiz_weight}%\n")

    quizzes = []
    data = []
    count = 0
    for (asn,score,cat) in getCategoryScores(student,'quizzes'):
        entry = {'Quiz': asn.title}
        if score.status == 'p':
            entry['Score'] = 'Pending'
        elif score.status == 'x':
            entry['Score'] = 'Excused'
        elif score.status == 'm':
            entry['Score'] = 'Missing'
            count += 1
            quizzes.append(0)
        else:
            entry['Score'] = f'{score.score:.2f}'
            quizzes.append(score.score)
            count += 1

        data.append(entry)

    print(pd.DataFrame(data).to_string(index=False))
    print()

    quiz_total = dropNLowest(quizzes,2)

    print(f'\n- Quiz Average: {quiz_total:.2f}%\n\n')

    # ------------------------------
    # MPs
    # ------------------------------

    print(f"## MPs - Worth {mp_weight}%\n")

    mps = []
    data = []
    count = 0
    for (asn,score,cat) in getCategoryScores(student,'mps'):
        entry = {'MP': asn.title}
        s = 0
        if score.status == 'p':
            entry['Score'] = 'Pending'
        elif score.status == 'x':
            entry['Score'] = 'Excused'
        elif score.status == 'm':
            entry['Score'] = 'Missing'
            mps.append(0)
            count += 1
        else:
            entry['Score'] = f'{score.score:.2f}'
            mps.append(score.score)
            count += 1

        data.append(entry)

    print(pd.DataFrame(data).to_string(index=False))
    print()

    mp_total = dropNLowest(mps,1)

    print(f'\n- MP Average: {mp_total:.2f}%\n\n')

    # ------------------------------
    # Exams
    # ------------------------------

    # The status for an exam should be set to 'pending' until the exam is done.
    # If the exam is over, the status should be set to 'missing'.
    # If the status is set to 'x', then it is set to excused.
    # TODO: Decide what happens to excused exams if zones are retconned.

    exam_count = 0
    exam_total = 0

    final_zones = {}
    final_scores = {}

    # Get Final Exam zones
    query = session.query(Assignment).filter(Assignment.slug == 'final')
    if query.count() == 0: # Final exam not loaded yet.
        pass
    else:
        final = query.first()
        for zone,_,score in session.query(Zone,Assignment,Score). \
                filter(Zone.exam_id == final.id,
                       Zone.assignment_id == Assignment.id,
                       Score.assignment_id == Assignment.id,
                       Score.student_id == student.id).order_by(Zone.order).all():
            final_zones[zone.slug] = zone
            final_scores[zone.slug] = score

    # ------------------------------
    # Exam 1
    # ------------------------------

    exam = session.query(Assignment).filter(Assignment.slug == 'exam-1').first()

    exam_status = session.query(Score).filter(Score.student_id == student.id,
                                              Score.assignment_id == exam.id).first().status

    if exam_status == 'x':
        print(' - Exam is excused.')
    else:
        exam1_score = report_exam(exam,exam_weight,student,final_zones,final_scores)

        if exam1_score is not None:
            exam_total += exam1_score
            exam_count += 1
        else:
            if exam_status == 'p':
                print(' - Exam is pending.')
            elif exam_status == 'm':
                print(' - Exam is missing.')
                exam_count += 1

    # ------------------------------
    # Exam 2
    # ------------------------------

    exam = session.query(Assignment).filter(Assignment.slug == 'exam-2').first()
    exam_status = session.query(Score).filter(Score.student_id == student.id,
                                              Score.assignment_id == exam.id).first().status

    if exam_status == 'x':
        print(' - Exam is excused.')
    else:
        exam2_score = report_exam(exam,exam_weight,student,final_zones,final_scores)

        if exam2_score is not None:
            exam_total += exam2_score
            exam_count += 1
        else:
            if exam_status == 'p':
                print(' - Exam is pending.')
            elif exam_status == 'm':
                print(' - Exam is missing.')
                exam_count += 1

    # Summarize Exams

    if exam_count > 0:
        exam_total /= exam_count
    else:
        exam_weight = 0

    # ------------------------------
    # Project
    # ------------------------------

    project_total = 0
    if student.credit == 4:
        print(f"## Project - Worth {project_weight}%")

        (asn,score,cat) = getCategoryScores(student,'project')[0]
        s = 0
        if score.status == 'p':
            print('-', asn.title,'Pending')
            project_weight = 0
        elif score.status == 'x':
            print('-', asn.title,'Excused')
            project_weight = 0
        elif score.status == 'm':
            print('-', asn.title,'Missing')
            s = 0
        else:
            print(f'- {asn.title} {score.score:.2f}')
            s = score.score

        project_total = s # Maybe not efficient, but keeps the calc code the same.

    score = quiz_total * quiz_weight + mp_total * mp_weight + \
        exam_total * exam_weight + project_total * project_weight

    score = score / (quiz_weight + mp_weight + exam_weight + project_weight)

    print("\n\n")
    print(f'## Total Score: {score:.2f}, Letter Grade: {curve(score)}\n\n')
    return curve(score)



# --------------------------------------------------------------------------------
# Report Parser
# --------------------------------------------------------------------------------

report_parser = subparsers.add_parser('report', aliases=['r'], help='Report commands')
report_parser.set_defaults(func=report_parser.print_help)

sstp = report_parser.add_subparsers(title='report subcommands', help='report subcommand help')

#    Select Netids
get_netid_parser = sstp.add_parser('netid', aliases=['n'], help='report for a specific netid')
get_netid_parser.add_argument('netid', help='the netid of the student')
get_netid_parser.set_defaults(func=report_netid)
