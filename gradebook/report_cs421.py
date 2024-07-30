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

    scores.sort()

    if len(scores) == 0:
        return {}
    if len(scores) < n:
        print(f"Dropping {len(scores)-1} lowest score(s). " +
        "(Need > {n} scores before all drops can occur.)")
        n = len(scores)-1
    else:
        print(f"Dropping {n} lowest score(s).")

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

    print('# Grade Report for {student.netid}\n')
    print(f'Generated {show(datetime.datetime.now())}\n\n')

    # ------------------------------
    # Quizzes
    # ------------------------------

    print(f"## Quizzes - Worth {quiz_weight}%")

    quizzes = []
    count = 0
    for (asn,score,cat) in getCategoryScores(student,'quizzes'):
        s = 0
        if score.status == 'p':
            print('-', asn.title,'Pending')
            continue
        if score.status == 'x':
            print('-', asn.title,'Excused')
            continue
        if score.status == 'm':
            print('-', asn.title,'Missing')
            s = 0
        else:
            print(f'- {asn.title} {score.score:.2f}')
            s = score.score

        quizzes.append(s)
        count = count + 1.0

    quiz_total = dropNLowest(quizzes,2)

    print(f'\n- Quiz Average: {quiz_total:.2f}%\n\n')

    # ------------------------------
    # MPs
    # ------------------------------

    print(f"## MPs - Worth {mp_weight}%")

    mps = []
    count = 0
    for (asn,score,cat) in getCategoryScores(student,'mps'):
        s = 0
        if score.status == 'p':
            print('-', asn.title,'Pending')
            continue
        if score.status == 'x':
            print('-', asn.title,'Excused')
            continue
        if score.status == 'm':
            print('-', asn.title,'Missing')
            s = 0
        else:
            print(f'- {asn.title} {score.score:.2f}')
            s = score.score

        mps.append(s)
        count = count + 1.0

    mp_total = dropNLowest(mps,1)

    print(f'\n- MP Average: {mp_total:.2f}%\n\n')

    # ------------------------------
    # Exam 1
    # ------------------------------


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
        project_total * project_weight

    score = score / (quiz_weight + mp_weight + project_weight)

    print("\n\n")
    print(f'## Total Score: {score:.2f}\n\n')
    print(f'## Total Score: {score}, Letter Grade: {curve(score)}\n\n')
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
