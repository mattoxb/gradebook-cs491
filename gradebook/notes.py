#!/usr/bin/env python3

"""
This module provides the database class and all functions to handle
notes for students.  This is where we can record e.g. extensions.

There are two functions:
- add-note
- show-notes
"""

import csv
from sqlalchemy import Column, Integer, String, ForeignKey, TIMESTAMP
from sqlalchemy.sql import func
import pandas as pd

from gradebook.db import session, Base
from gradebook.parser import subparsers
from gradebook.students import Student

class Note(Base):
    "The note information, part of sqlalchemy's ORM."
    __tablename__ = "notes"

    id = Column(Integer, primary_key=True)
    student_id = Column(Integer,ForeignKey(Student.id))
    created = Column(TIMESTAMP(timezone=False), nullable=False, server_default = func.now())
    note = Column(String)

def add_note(params):
    "Add a note for a student."

    student = session.query(Student).filter(Student.netid == params['netid']).first()

    session.add(Note(student_id = student.id, note=params['note']))

    session.commit()

def show_notes(params):
    "Add a note for a student."

    student = session.query(Student).filter(Student.netid == params['netid']).first()

    for row in session.query(Note).filter(Note.student_id == student.id).order_by(Note.created).all():
        print(f'{row.id: 3d} {str(row.created)[0:19]} - {row.note}')

# --------------------------------------------------------------------------------
# Category Parser
# --------------------------------------------------------------------------------

category_parser = subparsers.add_parser('note', aliases=['n'],
                                        help='Note commands')
category_parser.set_defaults(func=lambda x: category_parser.print_help())

subs = category_parser.add_subparsers(title='note subcommands', help='note subcommand help')

add_parser = subs.add_parser('add', aliases='a')
add_parser.add_argument('netid', type=str, help='The netid of the student you want to annotate.')
add_parser.add_argument('note', type=str, help='The text of the note.')
add_parser.set_defaults(func=add_note)

show_parser = subs.add_parser('show', aliases='s')
show_parser.add_argument('netid', type=str, help='The netid of the student you want to annotate.')
show_parser.set_defaults(func=show_notes)
