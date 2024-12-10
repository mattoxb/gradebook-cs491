import json
import csv
import re
import sys

# Function to read handles.csv and create a mapping of handle to netid
def read_handles_csv(csv_file):
    handle_to_netid = {}
    with open(csv_file, mode='r') as file:
        reader = csv.DictReader(file)  # Use DictReader to handle the header
        for row in reader:
            netid = row['netid']
            handle = row['handle']
            handle_to_netid[handle] = netid
    return handle_to_netid

# Function to slugify contest and problem names
def slugify(contest_name, problem_index, problem_name):
    return re.sub(r'[^a-zA-Z0-9]+', '-', f"{contest_name}-{problem_index}-{problem_name}").lower()

# Function to process JSON file and generate the score output
def process_scores(json_file, csv_file):
    # Load JSON data
    with open(json_file, 'r') as file:
        data = json.load(file)
    
    # Read handles.csv to map handles to netids
    handle_to_netid = read_handles_csv(csv_file)
    
    # Extract contest information
    contest_name = data['result']['contest']['name']
    contest_id = data['result']['contest']['id']
    
    # Get the list of problems
    problems = data['result']['problems']
    
    print("slug,netid,score")
    # Extract scores for each row in the "rows" array
    for row in data['result']['rows']:
        if row['party']['participantType'] != 'CONTESTANT' or row['party']['contestId'] != contest_id:
            continue
        
        # Get the handle for the current participant
        handle = row['party']['members'][0]['handle']
        netid = handle_to_netid.get(handle, 'unknown')  # Fallback to 'unknown' if handle not found
        if netid=='unknown':
            continue
        
        # Get the list of problem results
        problem_results = row['problemResults']
        
        # Loop through problems and their results
        for problem, result in zip(problems, problem_results):
            problem_index = problem['index']
            problem_name = problem['name']
            points = float(result['points']) * 100
            
            # Create slug for the problem
            slug = slugify(contest_name, problem_index, problem_name)
            
            # Generate output line
            output_line = f"{slug},{netid},{points}"
            
            # Print the result
            print(output_line)

# Example usage
json_file = sys.argv[1]  # Replace with your JSON file path
csv_file = '../data-files/handles.csv'    # Replace with your handles.csv file path
process_scores(json_file, csv_file)
