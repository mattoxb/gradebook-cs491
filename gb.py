#!/usr/bin/env python3

from gb.parser import parser

#import gb.categories as categories

import gb.students as students

args = parser.parse_args()

if hasattr(args, 'func'):
    args.func(vars(args))
else:
    parser.print_help()
