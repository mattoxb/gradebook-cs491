#!/usr/bin/env python3

"""
This module contains the configuration variables.
"""

DATABASE = 'cs491cap-fa24-grades'
CONNECTION = f'postgresql+psycopg2:///{DATABASE}'

GITHUB_URL = 'https://github.com/illinois-cs-coursework/sp24_cs491cap_{netid}.git'

# 1 + YYYY + [1,5,8]
TERM_CODE = '120248'
CRNS      = ['65816']

# This is for Coursera, the format is slug: (normal,override)

# For this semester, due to mastery learning, we will not read the exam score from Coursera,
# but instead read the exam report directly from PL.

COURSERA_MAPPING = {
    'mp-1': ("Original Assessment Grade: MP 1 - Haskell (MPs) (Passing Threshold: 0.8)",
             "Assessment Grade Override: MP 1 - Haskell (MPs) (Passing Threshold: 0.8)"),
    }
