#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser('gradebook')
subparsers = parser.add_subparsers(title='subcommands', help='subcommand help')

parser.set_defaults(func=lambda x: parser.print_help())
