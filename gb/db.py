# db.py

"""
This module contains the database connection code.

Will add code here to backup and restore the postgres database.
"""

import subprocess

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from gb.config import DATABASE, CONNECTION

from gb.parser import subparsers

engine = create_engine(CONNECTION)
Session = sessionmaker(bind=engine)
Base = declarative_base()
session = Session()

def init_tables(params):
    "Initialize the database tables."
    print("Initializing tables.")
    Base.metadata.create_all(engine)
    session.commit()

def backup_database(params):
    "Create a backup of the database"

    with open(params['fname'],'w') as file:
        subprocess.check_call(['pg_dump', DATABASE], stdout=file)

def restore_database(params):
    "Restore the database from backup"

    with open(params['fname']) as file:
        subprocess.check_call(['psql', DATABASE], stdin=file)
    pass

# --------------------------------------------------------------------------------
# Database Parser
# --------------------------------------------------------------------------------

database_parser = subparsers.add_parser('database', aliases=['d','db'],
                                        help='Database commands')
database_parser.set_defaults(func=lambda x: database_parser.print_help())

subs = database_parser.add_subparsers(title='database subcommands', help='database subcommand help')

init_parser = subs.add_parser('init', aliases=['i'],
                                  help='Initialize the tables in the database')
init_parser.set_defaults(func=init_tables)

backup_parser = subs.add_parser('backup', aliases=['b'],
                                help='Create a backup of the database')
backup_parser.add_argument('--fname', '-f', default='database.sql', type=str,
                             help='The name of the database backup file')
backup_parser.set_defaults(func=backup_database)

restore_parser = subs.add_parser('restore', aliases=['r'],
                                help='Restore the database from backup')
restore_parser.add_argument('--fname', '-f', default='database.sql', type=str,
                             help='The name of the database restore file')
restore_parser.set_defaults(func=restore_database)
