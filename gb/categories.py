#!/usr/bin/env python3

"""
This module provides the database class and all functions to handle
assignment categories.

There are two functions:
- load-categories
- show-categories
"""

import csv
from sqlalchemy import Column, Integer, String
import pandas as pd

from gb.db import session, Base
from gb.parser import subparsers

class Category(Base):
    "The assignment category information, part of sqlalchemy's ORM."
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True)
    slug = Column(String,unique=True)
    title = Column(String)

def load_categories(params):
    "Load the categories into the database."

    with open(params['fname'], encoding='utf-8', newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            q = session.query(Category).filter(Category.slug == row['slug'])
            if q.count() == 0:  # new category
                c = Category()
                c.slug = row['slug']
                c.title = row['title']
                session.add(c)
            else:
                c = q.first()
                c.title = row['title']
                session.add(c)
    session.commit()

    print_categories(params)

def print_categories(params):
    "Print the categories as a pandas dataframe."

    q = session.query(Category)
    result = [row.__dict__ for row in q.all()]

    # Remove the '_sa_instance_state' key that SQLAlchemy adds to each row
    for row in result:
        row.pop('_sa_instance_state', None)

    # Create a DataFrame
    df = pd.DataFrame(result)[['id','slug','title']]

    print(df)

# --------------------------------------------------------------------------------
# Category Parser
# --------------------------------------------------------------------------------

category_parser = subparsers.add_parser('categories', aliases=['c','ca','cat'],
                                        help='Category commands')
category_parser.set_defaults(func=lambda x: category_parser.print_help())

subs = category_parser.add_subparsers(title='category subcommands', help='category subcommand help')
load_parser = subs.add_parser('load', aliases=['l','load'],
                                  help='Load / update the categories.')
load_parser.add_argument('--fname', '-f', default='categories.csv', type=str,
                             help='The CSV file with the category info.')
load_parser.set_defaults(func=load_categories)

print_parser = subs.add_parser('print', aliases=['p'], help='Print the categories.')
print_parser.set_defaults(func=print_categories)
