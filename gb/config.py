#!/usr/bin/env python3

"""
This module contains the configuration variables.
There is just one: DATABASE.

It will have the form 'postgresql+psycopg2:///cs421-su24-grades',
and is passed to sqlalchemy's `create_engine`.
"""

DATABASE = 'postgresql+psycopg2:///cs421-su24-grades'
