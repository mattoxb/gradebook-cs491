#!/usr/bin/env python3

"""
This module provides the database class and all functions to handle
student data.

The class is based on the data given by UIUC's "download roster"
functionality.

It creates a `student` subcommand with four subcommands of its own:
- show roster :: display or return a pandas frame of the current roster
- netid :: fzf search the roster and return the matching netid(s)
- uin :: fzf search the roster and return the matching UIN(s)
- upload roster :: load the rpt_all_students.xls
"""

from sqlalchemy import Column, Integer, String
import pandas as pd
from bs4 import BeautifulSoup
from pyfzf.pyfzf import FzfPrompt

from gb.db import session, Base
from gb.parser import subparsers

# --------------------------------------------------------------------------------
# Student Class
# --------------------------------------------------------------------------------

class Student(Base):
    "The student information that is in the roster, part of sqlalchemy's ORM."
    __tablename__ = 'students'

    id = Column(Integer, primary_key=True)
    netid = Column(String(9),nullable=False,unique=True)
    status = Column(String(1),nullable=False)
    uin = Column(String(9),unique=True)
    gender = Column(String(3))
    name = Column(String)
    credit = Column(Integer)
    level = Column(String(2))
    year = Column(String)
    subject = Column(String)
    number = Column(String(4))
    section = Column(String(4))
    crn = Column(Integer)
    degree = Column(String)
    major = Column(String)
    college = Column(String)
    program_name = Column(String)
    ferpa = Column(String(1))
    comments = Column(Integer)
    admit_term = Column(String)
    email = Column(String)

    def __repr__(self):
        "Show a human-readable representation of the student object"
        out = ""
        if self.id is not None:
            out = f"<Student {self.id}: {self.name} ({self.netid}) {self.uin}>"
        else:
            out = f"<Student NULL: {self.name} ({self.netid}) {self.uin}>"

        return out

# --------------------------------------------------------------------------------
# Student Functions
# --------------------------------------------------------------------------------

def load_roster(params):
    "Loads the UIUC rpt_all_student.xls file and adds the information to the database"

    # Open an html table containing the roster.

    table = BeautifulSoup(open(params["fname"],encoding='utf-8').read(),features="html5lib")

    # Mark all students as provisionally dropped untill we know otherwise

    session.query(Student).filter(Student.status=='r').update({Student.status: 'D'})

    print("New Students:")
    new_students = []

    for row in table.select('table tbody tr'):
        elts = [td.text for td in row.select('td')]
        netid = elts[0]
        q = session.query(Student).filter(Student.netid == netid)
        if q.count() == 0:  # new student
            s = Student()
            for (k,v) in zip(["netid","uin","admit_term","gender","name","email","credit","level",
                              "year","subject","number","section","crn","degree","major","college",
                              "program_name","ferpa"],elts):
                setattr(s,k,v)

            s.status = 'r'
            new_students.append(s.netid)
            print(s)
        else:
            s = q.first()
            s.section = elts[11]
            s.status = 'r'

        session.add(s)

    session.commit()
    # Show all the dropped students

    print("Dropped:")
    for dropee in session.query(Student).filter(Student.status=='d').all():
        print(f"  {dropee.netid}")

    print("Newly Dropped:")
    for dropee in session.query(Student).filter(Student.status=='D').all():
        print(f"  {dropee.netid}")
        dropee.status = 'd'

    session.commit()

    # If no new students we are done.
    if not new_students:
        return

    # Otherwise, we need to add pending scores for new students
    ## First get the assignment ids

    from gb.assignments import Assignment
    from gb.scores import Score

    ids = []
    for asn in session.query(Assignment).all():
        ids.append(asn.id)

    # Get the new students

    for student in session.query(Student).filter(Student.netid.in_(new_students)).all():
        for assignment in ids:
            s = Score()
            s.student_id = student.id
            s.assignment_id = assignment
            s.status = 'p'
            s.score = 0
            session.add(s)

    session.commit()

def show_roster(args):
    "Create a pandas dataframe of the current students."
    q = session.query(Student).filter(Student.status=='r')

    if 'section' in args and args['section'] is not None:
        q = q.filter(Student.section == args['section'])

    result = [row.__dict__ for row in q.all()]
    print(len(result))

    # Remove the '_sa_instance_state' key that SQLAlchemy adds to each row
    for row in result:
        row.pop('_sa_instance_state', None)

    # Create a DataFrame
    df = pd.DataFrame(result)
    pd.set_option('display.max_rows', None)

    out = df[['id','netid','uin','name','section','credit','year','major']].to_string(index=False)

    if 'return' in args:
        return out

    print(out)
    return None

def get_netid(args):
    "Search the roster and select the netid(s)"
    args['return'] = True
    roster = show_roster(args)

    names = roster.split('\n')

    netids = map(lambda x: x.split()[1], FzfPrompt().prompt(names,'--multi'))

    for netid in netids:
        print(netid)

def get_uin(args):
    "Search the roster and select the uin(s)"
    args['return'] = True
    roster = show_roster(args)

    names = roster.split('\n')

    uins = map(lambda x: x.split()[2], FzfPrompt().prompt(names,'--multi'))

    for uin in uins:
        print(uin)

# --------------------------------------------------------------------------------
# Student Parser
# --------------------------------------------------------------------------------

student_parser = subparsers.add_parser('student', aliases=['st','stu'], help='Student commands')
student_parser.set_defaults(func=lambda x: student_parser.print_help())

sstp = student_parser.add_subparsers(title='student subcommands', help='student subcommand help')

#    Select Netids
get_netid_parser = sstp.add_parser('netid', aliases=['n'], help='get Netids')
get_netid_parser.add_argument('-s','--section',type=str,help='Filter by section')
get_netid_parser.set_defaults(func=get_netid)

#    Select Uins
get_uin_parser = sstp.add_parser('uin', aliases=['u'], help='get Uins')
get_uin_parser.add_argument('-s','--section',type=str,help='Filter by section')
get_uin_parser.set_defaults(func=get_uin)

#    Show the Roster
show_roster_parser = sstp.add_parser('show-roster', aliases=['s','show'], help='print the roster')
show_roster_parser.add_argument('-s','--section',type=str,help='Filter by section')
show_roster_parser.set_defaults(func=show_roster)

#    Import the Roster
roster_parser = sstp.add_parser('load-roster', aliases=['l','ld','lr','load'],
                                help='load the roster')
roster_parser.add_argument('-f', '--fname', type=str, default='rpt_all_students.xls',
                           help='The file name of the roster, defaults to rpt_all_students.xls')
roster_parser.set_defaults(func=load_roster)
