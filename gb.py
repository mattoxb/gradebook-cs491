#!/usr/bin/env python3

"""
This is the main gradebook app.

Use the gb/config.py file to specify the exact database you want to use.

Use the imports to pull in whichever features you need.
In particular, the modules of form csXXXSSYY contain the grading formulas
needed for each particular semester.
"""

from gb.parser import parser
import gb.students

#import gb.categories as categories

args = parser.parse_args()

if hasattr(args, 'func'):
    args.func(vars(args))
else:
    parser.print_help()
