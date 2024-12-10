import json
from datetime import datetime, timezone, timedelta
import re
import sys

# Load JSON data
with open(sys.argv[1],encoding='utf8') as file:
    data = json.loads(file.read())

with open('num') as file:
    number = int(file.read())

string_value = 'problems'

# Extract contest and problem information
contest = data['result']['contest']
contest_name = contest['name']
start_time_seconds = contest['startTimeSeconds']

# Convert start time to GMT-5
gmt_minus_5 = timezone(timedelta(hours=-5))
start_time = datetime.fromtimestamp(start_time_seconds, tz=gmt_minus_5)
formatted_date = start_time.strftime('%Y-%m-%d')

def slugify(string):
    return re.sub(r'[^a-zA-Z0-9]+', '-', string).lower()

# Process each problem in the "problems" array
for problem in data['result']['problems']:
    problem_index = problem['index']
    problem_name = problem['name']

    # Create the slugified string
    slug = slugify(f"{contest_name}-{problem_index}-{problem_name}")
  
    # Create the final output line
    output_line = f"{number},{string_value},{slug},{1},{formatted_date},{contest_name} {problem_index}: {problem_name}"
  
    number += 1

    # Print the result
    print(output_line)

with open('num','w') as file:
    file.write(str(number))
