#!/usr/bin/env python3

import gb.db as db
from gb.db import *

from gb.parser import parser, subparsers

#import gb.categories as categories
#import gb.students as students

args = parser.parse_args()

if hasattr(args, 'func'):
    args.func(vars(args))
else:
    parser.print_help()
