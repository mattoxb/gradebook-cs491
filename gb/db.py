# db.py

"""
This module contains the database connection code.

Will add code here to backup and restore the postgres database.
"""

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

from gb.config import DATABASE

engine = create_engine(DATABASE)
Session = sessionmaker(bind=engine)
Base = declarative_base()
session = Session()
