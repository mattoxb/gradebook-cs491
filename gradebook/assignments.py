#!/usr/bin/env python3

"""
This module provides the database class and all functions to handle
assignments.

There are two functions:
- load-assignments
- show-assignments
"""

import csv
from sqlalchemy import Column, Integer, String, ForeignKey
import pandas as pd

from gradebook.db import session, Base
from gradebook.parser import subparsers

from gradebook.categories import Category

class Assignment(Base):
    "This class holds the information for assignments."
    __tablename__ = 'assignments'

    id = Column(Integer, primary_key=True)
    slug = Column(String(20),nullable=False,unique=True)
    title = Column(String)
    category_id = Column(Integer, ForeignKey('categories.id'))
    max_points = Column(Integer)

def load_assignments(params):
    """Load assignments into the database from a CSV.  If an assignment is already in the
    database it will be updated.  If you remove a line from the CSV the assignment will be
    left as is.

    Any assignment that hasn't been entered before will have a Pending score entered for 
    all existing students.  We will not remove scores though.  Should we?
    """

    # Get category slugs

    cids = {}
    for cat in session.query(Category).all():
        cids[cat.slug] = cat.id

    # Get pre-existing assignments

    new_asns = []

    with open('assignments.csv', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            q = session.query(Assignment).filter(Assignment.slug == row['slug'])
            if q.count() == 0:  # new category
                a = Assignment()
                a.slug = row['slug']
                a.category_id = cids[row['category']]
                a.title = row['title']
                a.max_points = int(row['max_points'])

                # Keep track of new assignments to insert pending scores.
                new_asns.append(a.slug)

            else:
                a = q.first()
                a.category_id = cids[row['category']]
                a.title = row['title']
                a.max_points = int(row['max_points'])
            session.add(a)
    session.commit()

    # If no new assignments we are done.
    if not new_asns:
        return

    print("Adding pending scores for new assignments.")

    from gradebook.scores import Score
    from gradebook.students import Student

    # Otherwise, we need to add pending scores for new assignments
    ## First get the student ids

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


def print_assignments(params):
    "Print the assignments as a pandas dataframe."

    q = session.query(Assignment)
    result = [row.__dict__ for row in q.all()]
    print(result)

    # Remove the '_sa_instance_state' key that SQLAlchemy adds to each row
    for row in result:
        row.pop('_sa_instance_state', None)

        # Create a DataFrame
        df = pd.DataFrame(result)

    print(df)


# --------------------------------------------------------------------------------
# Category Parser
# --------------------------------------------------------------------------------

assignment_parser = subparsers.add_parser('assignments', aliases=['a','as','asn'],
                                        help='Assignment commands')
assignment_parser.set_defaults(func=lambda x: assignment_parser.print_help())

subs = assignment_parser.add_subparsers(title='assignment subcommands', help='assignment subcommand help')
load_parser = subs.add_parser('load', aliases=['l'],
                                  help='Load / update the assignments.')
load_parser.add_argument('--fname', '-f', default='assignments.csv', type=str,
                             help='The CSV file with the assignment info.')
load_parser.set_defaults(func=load_assignments)

print_parser = subs.add_parser('print', aliases=['p'], help='Print the assignments.')
print_parser.set_defaults(func=print_assignments)
