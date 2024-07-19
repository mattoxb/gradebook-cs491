# db.py
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

engine = create_engine('postgresql+psycopg2:///cs421-su24-grades')
Session = sessionmaker(bind=engine)
Base = declarative_base()
session = Session()
