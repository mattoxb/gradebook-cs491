#!/usr/bin/env python3

"""
This module collects the names of zones and the questions that go in to
them from a Prairielearn instance.  This is to support mastery learning /
second chance style exams.

The exam_zone table uses an assignment_id to identify the exam and loads
the zone names from PL.  Each zone should also be an assignment name in
the category `zones`.  Each slug will have the assignment slug prepended.

For example, an exam zone `Direct Recursion` in `exam-1` will be given
slug name `exam-1-direct-recursion`.
"""

import json
from sqlalchemy import Column, Integer, String, ForeignKey, delete
import pandas as pd
import csv

from gradebook.db import session, Base
from gradebook.parser import subparsers
from gradebook.assignments import Assignment
from gradebook.categories import Category
from gradebook.students import Student, match_coursera_to_roster
from gradebook.scores import Score
from gradebook.utilities import slugify, levenshtein_distance
from gradebook.scores import create_pending_scores

class Zone(Base):
    "This class holds the information about exam zones and questions."
    __tablename__ = 'zones'

    id = Column(Integer, primary_key=True)
    exam_id = Column(Integer, ForeignKey('assignments.id'))
    assignment_id = Column(Integer, ForeignKey('assignments.id'))
    slug = Column(String,nullable=False,unique=True)
    title = Column(String)
    order = Column(Integer)
    max_points = Column(Integer)

    def __repr__(this):
        return f'''Zone({this.id} Exam: {this.exam_id} Assignment: {this.assignment_id} \
        Title: {this.title} Slug: {this.slug})'''
  

class Question(Base):
    "This class holds the information about the questions in each zone."
    __tablename__ = 'questions'

    id = Column(Integer, primary_key=True)
    exam_id = Column(Integer, ForeignKey('assignments.id'))
    assignment_id = Column(Integer, ForeignKey('assignments.id')) 
    zone_id = Column(Integer, ForeignKey('zones.id'))
    path = Column(String,nullable=False)
    max_points = Column(Integer)

def load_exam_zones(params):
    """Load the PrairieLearn infoAssessment.json and populate the zone information.
    TODO: Auto delete and cascade before adding information."""

    # Get exam assignment

    exam = session.query(Assignment).filter(Assignment.slug == params['assignment']).first()
    if exam is None:
        print("Assignment not found.")
        return
    exam_points = 0

    # If the zones category is not created go ahead and create it.
    zone_category = session.query(Category).filter(Category.slug == 'zones').first()
    if zone_category is None:
        zone_category = Category(slug = 'zones',
                                 title = 'Zones')
        session.add(zone_category)
        session.flush() # generate the id

    if params['fname'] == '':
        params['fname'] = f'data-files/{exam.slug}.json'

    # Finally, we are able to open the json file.

    with open(params['fname']) as file:
        data = json.load(file)

    order = 0
    new_asns = []
    for zone_data in data['zones']:
        slug = slugify(exam.slug + ' ' + zone_data['title'])
        print(zone_data['title'] + ': ' + slug)
        query = session.query(Zone).filter(Zone.exam_id == exam.id,
                                           Zone.slug == slug)
        order += 1

        # First we create the zone.  We will create the corresponding
        # assignment in a bit.

        if query.count() == 0:
            zone = Zone(exam_id = exam.id,
                        slug = slug,
                        title = zone_data['title'],
                        order = order)
            new_asns.append(slug)
            session.add(zone)
            session.flush()  # we will need the zone id immediately
        else:
            zone = query.first()

        # Get the corresponding assignment that matches the zone.

        query = session.query(Assignment).filter(Assignment.slug == slug)

        if query.count() == 0:
            assignment = Assignment(category_id = zone_category.id,
                                    title = zone_data['title'],
                                    slug = slug,
                                    order = order)
            session.add(assignment)
            session.flush()  # We will need the assignment id immediately
            new_asns.append(slug)
        else:
            assignment = query.first()

        zone.assignment_id = assignment.id

        points = 0

        for question_data in zone_data['questions']:
            points_data = question_data['points']

            if isinstance(points_data,list):
                points_data = points_data[0]

            points = points + points_data * question_data['numberChoose']

            for alternative in question_data['alternatives']:
                print(alternative)
                query = session.query(Question).filter(Question.zone_id == zone.id,
                                                       Question.path == alternative['id'] )
                if query.count() == 0:
                    question = Question(assignment_id = zone.assignment_id,
                                        exam_id = zone.exam_id,
                                        zone_id = zone.id,
                                        path = alternative['id'],
                                        max_points = points_data)
                    session.add(question)

        assignment.max_points = points
        zone.max_points = points
        exam_points += points

        session.add(assignment)
        session.add(zone)

    exam.max_points = exam_points
    session.add(exam)
    session.commit()
    create_pending_scores(new_asns)

# UID,UIN,Username,Name,Role,Assessment,Assessment instance,Question,Question instance,Question points,Max
# points,Question % score,Auto points,Max auto points,Manual points,Max manual points,Date,Highest submission score,Last
# submission score,Number attempts,Duration seconds,Assigned manual grader,Last manual grader

def set_coursera_mapping(params):

    student = session.query(Student).filter(Student.netid == params['netid']).first()

    statement = delete(Coursera_UID).where(Coursera_UID.student_id == student.id)
    session.execute(statement)

    statement = delete(Coursera_UID).where(Coursera_UID.uid == params['uid'])
    session.execute(statement)

    coursera = Coursera_UID(uid = params['uid'], student_id = student.id)
    session.add(coursera)
    session.commit()


def update_exam_scores(student,zones,zone_scores):
    "Update the zone scores and total score for the student."

    for zid,score in zone_scores.items():
        score = session.query(Score).filter(Score.student_id == student.id,
                                            Score.assignment_id == zones[zid].assignment_id).first()
        if zone_scores[zid] is None:
            score.status = 'm'
            score.score = 0
        else:
            score.score = zone_scores[zid]
            score.status = 'g'
        session.add(score)

    session.commit()

def load_exam_scores(params):
    "Load exam score information and update scores."

    query = session.query(Assignment).filter(Assignment.slug == params['assignment'])

    if query.count() == 0:
        print("Exam slug not found.")
        return
    exam = query.first()

    # Get all the zones that belong to this assignment

    query = session.query(Zone).filter(Zone.exam_id == exam.id)
    if query.count() == 0:
        print("This assignment does not have zones recorded.")
        return

    zones_data = query.all()

    # This will keep track of all the scores for a student so we can update them at the end.

    empty = {}
    zones = {}
    for z in zones_data:
        empty[z.id] = None
        zones[z.id] = z

    seen = {}

    # Get all the questions

    query = session.query(Question).filter(Question.exam_id == exam.id)
    if query.count() == 0:
        print("This assignment does not have questions recorded.")
        return

    questions = {}
    for question in query.all():
        questions[question.path] = question

    # Okay! We can read in the scores now.

    with open(params['fname'], newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        last_student = None

        zone_scores = empty.copy()

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
                        print(f"Student UIN {row['UIN']} name {row['Name']} not found.")
                        continue
                    student = q.first()
                    seen[row['UIN']] = student
            else: # Coursera Entry
                if row['UID'] in seen:
                    student= seen[row['UID']]
                else:
                    student = match_coursera_to_roster(row['UID'],row['Name'])
                    if student is None:
                        print(f"Coursera Student {row['Name']} not found.\nUID: {row['UID']}")
                        continue
                    seen[row['UID']] = student

            # If we have switched students, we need to update their scores.

            if last_student != student:
                if last_student is not None:
                    update_exam_scores(last_student,zones,zone_scores)
                last_student = student
                zone_scores = empty.copy()

            question = questions[row['Question']]
            if row['Highest submission score'] != '':
                if zone_scores[question.zone_id] is None:
                    zone_scores[question.zone_id] = 0

                zone_scores[question.zone_id] += float(row['Auto points']) #* question.max_points

        # Final entry read, update the last student.
        update_exam_scores(student,zones,zone_scores)


# --------------------------------------------------------------------------------
# Exam Zone Parser
# --------------------------------------------------------------------------------
        
zone_parser = subparsers.add_parser('exam', aliases=['e'],
                                    help='Exam commands')
zone_parser.set_defaults(func=zone_parser.print_help)

subs = zone_parser.add_subparsers(title='zone subcommands', help='zone subcommand help')
load_zones_parser = subs.add_parser('load-zones', aliases=['lz'],
                              help='Load exam zones.')
load_zones_parser.add_argument('assignment', type=str,
                         help='The slug of the corresponding assignment.')
load_zones_parser.add_argument('--fname', '-f', default='', type=str, # will use slug.json if not given
                         help='The infoAssessment.json file.')
load_zones_parser.set_defaults(func=load_exam_zones)

load_scores_parser = subs.add_parser('load-scores', aliases=['ls'],
                              help='Load exam scores.')
load_scores_parser.add_argument('assignment', type=str,
                         help='The slug of the corresponding assignment.')
load_scores_parser.add_argument('fname', type=str,
                         help='The instance_questions.csv file.')
load_scores_parser.set_defaults(func=load_exam_scores)

set_coursera_parser = subs.add_parser('set-coursera', aliases=['sc'],
                              help='Set coursera mapping.')
set_coursera_parser.add_argument('netid', type=str,
                         help='The netid of the student.')
set_coursera_parser.add_argument('uid', type=str,
                         help='The coursera UID.')
set_coursera_parser.set_defaults(func=set_coursera_mapping)
