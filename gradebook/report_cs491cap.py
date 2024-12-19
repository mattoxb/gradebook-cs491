#!/usr/bin/env python3

"""
This module provides grade reports for CS 491 CAP.
"""

import pandas as pd

import datetime

# For github stuff
import os
import sys
import subprocess
from contextlib import redirect_stdout
from openpyxl import Workbook

from gradebook.config import GITHUB_URL, TERM_CODE, CRNS
from gradebook.db import session
from gradebook.parser import subparsers
from gradebook.categories import Category
from gradebook.scores import Score
from gradebook.students import Student, get_netid
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

    if scores is None:
        return None

    scores.sort()

    if len(scores) == 0:
        return {}
    if n > 0 and len(scores) < n:
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

def report_netid(netid, uin=''):
    "Generate a report for a given netid.  Returns the letter grade."

    if netid == '' and not uin == '':
        student = session.query(Student).filter(Student.uin == uin).first()
    else:
        student = session.query(Student).filter(Student.netid == netid).first()

    if student is None:
        print("Netid not found.")
        return None

    print(f'# Grade Report for {student.name} ({student.netid})\n')
    print("Errors?  Please email mattox@illionis.edu\n\n")

    print("\n# Attendance\n")

    attendance = []
    data = []
    count = 0
    for (asn,score,cat) in getCategoryScores(student,'attendance'):
        entry = {'Attendance': asn.title}
        s = 0
        if score.status == 'p':
            entry['Score'] = 'Pending'
        elif score.status == 'x':
            entry['Score'] = 'Excused'
        elif score.status == 'm':
            entry['Score'] = 'Missing'
            attendance.append(0)
            count += 1
        else:
            entry['Score'] = f'{score.score:.2f}'
            attendance.append(score.score)
            count += 1

        data.append(entry)
  
    print(pd.DataFrame(data).to_string(index=False))
    print()
    
    attendance_total = dropNLowest(attendance,0)

    print(f'\n- Attendance Average: {attendance_total:.2f}%\n\n')


    print("\n# Problems\n")

    problems = []
    data = []
    count = 0
    solves = 0
    for (asn,score,cat) in getCategoryScores(student,'problems'):
        entry = {'Problems': asn.title.ljust(50)}
        s = 0
        if score.status == 'p':
            entry['Score'] = 'Pending'
        elif score.status == 'x':
            entry['Score'] = 'Excused'
            solves = solves + 1
        elif score.status == 'm':
            entry['Score'] = 'Missing'
            problems.append(0)
            count += 1
        else:
            entry['Score'] = f'{score.score:.2f}'
            problems.append(score.score)
            if score.score > 0:
                solves = solves + score.score / 100
            count += 1

        data.append(entry)

    df = pd.DataFrame(data)
    print(df.to_string(index=False, col_space={'Problems': 50}))
    print()
   
    problems_total = dropNLowest(problems,0)

    if type(problems_total) != float:
        print(f'\n- Problems Average: 0%\n\n')
    else:
        print(f'\n- Problems Average: {problems_total:.2f}% ({solves}/{count} problems).\n\n')

    if attendance_total < 0.6 or solves < 60:
        result = "U"
    else:
        result = "S"
        
    print(f"\nResult: {result}\n")

    return result



def clone_and_run_report(netid,report):
    "Clone the repository and try to add the grade report to it."
    # Define the directory path
    dir_path = os.path.join('repos', netid)

    # Check if the directory exists
    if not os.path.isdir(dir_path):
        # If it doesn't exist, try to clone from the GitHub repository
        git_url = GITHUB_URL.replace('{netid}',netid)
        try:
            # Try to clone the repository
            subprocess.check_call(['git', 'clone', git_url, dir_path])

            # If cloning is successful, call the report function
            # return True
        except subprocess.CalledProcessError:
            # If clone fails, do nothing
            return False

    with open(f"repos/{netid}/README.txt",'w') as sys.stdout:
        report()
    try:
        subprocess.check_call(['git', '-C', dir_path, 'add', 'README.txt'])
        subprocess.check_call(['git', '-C', dir_path, 'commit', '-am' , '"Grade Report"'])
        subprocess.check_call(['git', '-C', dir_path, 'pull', '--rebase'])
        subprocess.check_call(['git', '-C', dir_path, 'push'])
    except subprocess.CalledProcessError:
        pass

    return True

def get_report(params):
    params['netid'] = params['netid'].replace('@illinois.edu','')

    if params['final']:
        write_final_grade_spreadsheet(params)

    elif params['github']:
        if params['netid'] == '' and params['all']:
            query = session.query(Student).filter(Student.status=='r')
            print("Reporting....")
            for student in query.all():
                clone_and_run_report(student.netid,lambda: report_netid(student.netid))
        else:
            if params['netid'] == '' and params['uin'] == '':
                params['netid'] = get_netid({'return':True})
            clone_and_run_report(params['netid'], lambda: report_netid(params['netid']))
            if params['all']:
                print("Warning: --all flag overridden by explicit mention of a netid.")

    elif params['uin'] == '' and params['netid'] == '' and params['all']:  # Output final grades
        with open(f"/dev/null",'w') as devnull:
            query = session.query(Student).filter(Student.status=='r')
            for student in query.all():
                result = None
                with redirect_stdout(devnull):
                    result = report_netid(student.netid)
                print(f"{student.uin},{result}")

    elif params['uin'] == '' and params['netid'] == '':
        report_netid(get_netid({'return': True}))

    else:
        report_netid(params['netid'], params['uin'])

def write_final_grade_spreadsheet(params):
    """Create the spreadsheet for uploading final grades to the university."""

    wb = Workbook()
    ws = wb.active

    if CRNS == [] or TERM_CODE == '':
        print("Warning: CRN and TERM_CODE were not defined.")

    ws.append(['Term Code','CRN','Student ID','Final Grade'])

    with open(f"/dev/null",'w') as devnull:
        query = session.query(Student).filter(Student.status=='r')
        for student in query.all():
            with redirect_stdout(devnull):
                result = report_netid(student.netid)
                data = [TERM_CODE,student.crn,student.uin,result]
                ws.append(data)

    wb.save('output-files/grades.xlsx')

# --------------------------------------------------------------------------------
# Report Parser
# --------------------------------------------------------------------------------

report_parser = subparsers.add_parser('report', aliases=['r'], help='Report commands')

#    Select Netids
report_parser.add_argument('--netid', '-n', type=str, default='', help='report for a specific netid')
report_parser.add_argument('--uin', '-u', type=str, default='', help='report for a specific uin')
report_parser.add_argument('--github', '-g', action='store_true', help='Report to github')
report_parser.add_argument('--all', '-a', action='store_true', help='Report all of them')
report_parser.add_argument('--final', '-f', action='store_true', help='Generate the final grade entry excel spreadsheet')
report_parser.set_defaults(func=get_report)
