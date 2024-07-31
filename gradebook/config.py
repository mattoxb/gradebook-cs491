#!/usr/bin/env python3

"""
This module contains the configuration variables.
There is just one: DATABASE.

It will have the form 'postgresql+psycopg2:///cs421-su24-grades',
and is passed to sqlalchemy's `create_engine`.
"""

DATABASE = 'cs421-su24-grades'
CONNECTION = f'postgresql+psycopg2:///{DATABASE}'

GITHUB_URL = 'https://github.com/illinois-cs-coursework/sp24_cs101_{netid}.git'

# This is for Coursera, the format is slug: (normal,override)

# For this semester, due to mastery learning, we will not read the exam score from Coursera,
# but instead read the exam report directly from PL.

COURSERA_MAPPING = {
    'mp-1': ("Original Assessment Grade: MP 1 - Haskell (MPs) (Passing Threshold: 0.8)",
             "Assessment Grade Override: MP 1 - Haskell (MPs) (Passing Threshold: 0.8)"),
    'mp-2': ("Original Assessment Grade: MP 2 - Interpreters (MPs) (Passing Threshold: 0.8)",
             "Assessment Grade Override: MP 2 - Interpreters (MPs) (Passing Threshold: 0.8)"),
    'mp-3': ("Original Assessment Grade: MP 3 - CPS (MPs) (Passing Threshold: 0.8)",
             "Assessment Grade Override: MP 3 - CPS (MPs) (Passing Threshold: 0.8)"),
    'mp-4': ("Original Assessment Grade: MP 4 - Parsing (MPs) (Passing Threshold: 0.8)",
             "Assessment Grade Override: MP 4 - Parsing (MPs) (Passing Threshold: 0.8)"),
    'mp-5': ("Original Assessment Grade: MP 5 - Scheme (MPs) (Passing Threshold: 0.8)",
             "Assessment Grade Override: MP 5 - Scheme (MPs) (Passing Threshold: 0.8)"),
    'mp-6': ("Original Assessment Grade: MP 6 - Type Inferencer (MPs) (Passing Threshold: 0.8)",
             "Assessment Grade Override: MP 6 - Type Inferencer (MPs) (Passing Threshold: 0.8)"),
    'quiz-1': ("Original Assessment Grade: Recursion Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Recursion Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-2": ("Original Assessment Grade: Interpreters Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Interpreters Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-3": ("Original Assessment Grade: Building Blocks Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Building Blocks Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-4": ("Original Assessment Grade: Lambda Calculus & Semantics Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Lambda Calculus & Semantics Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-5": ("Original Assessment Grade: Type Classes and Polymorphism Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Type Classes and Polymorphism Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-6": ("Original Assessment Grade: Monads Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Monads Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-7": ("Original Assessment Grade: Grammars Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Grammars Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-8": ("Original Assessment Grade: Parsing Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Parsing Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-9": ("Original Assessment Grade: Semantics Quiz (Quiz Total) (Passing Threshold: 0.8)",
               "Assessment Grade Override: Semantics Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-10": ("Original Assessment Grade: State Quiz (Quiz Total) (Passing Threshold: 0.8)",
                "Assessment Grade Override: State Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-11": ("Original Assessment Grade: State Quiz (Quiz Total) (Passing Threshold: 0.8)",
                "Assessment Grade Override: State Quiz (Quiz Total) (Passing Threshold: 0.8)"),
    "quiz-12": ("Original Assessment Grade: Pragmatics Quiz (Quiz Total) (Passing Threshold: 0.8)",
                "Assessment Grade Override: Pragmatics Quiz (Quiz Total) (Passing Threshold: 0.8)")
    #    ("exam-1": ("Original Assessment Grade: Exam 1 (Passing Threshold: 0.8)",
    #    "Assessment Grade Override: Exam 1 (Passing Threshold: 0.8)",))
    #    ("exam-2": ("Original Assessment Grade: Exam 2 (Passing Threshold: 0.8)",
    #    "Assessment Grade Override: Exam 2 (Passing Threshold: 0.8)",))
}

# (Quiz Total)","Plagiarism Flag Status: Parsing Quiz (Quiz Total)","Plagiarism Flag Evidence: Parsing Quiz (Quiz
# Total)","Original Assessment Grade: Semantics Quiz (Quiz Total) (Passing Threshold: 0.8)","Assessment Grade Override:
# Semantics Quiz (Quiz Total) (Passing Threshold: 0.8)","Submission Time (UTC): Semantics Quiz (Quiz Total)","Item
# Weighting (Percentage): Semantics Quiz (Quiz Total)","Points Scored: Semantics Quiz (Quiz Total)","Points Total
# Possible: Semantics Quiz (Quiz Total)","Plagiarism Flag Status: Semantics Quiz (Quiz Total)","Plagiarism Flag Evidence:
# Semantics Quiz (Quiz Total)","Original Assessment Grade: State Quiz (Quiz Total) (Passing Threshold: 0.8)","Assessment
# Grade Override: State Quiz (Quiz Total) (Passing Threshold: 0.8)","Submission Time (UTC): State Quiz (Quiz Total)","Item
# Weighting (Percentage): State Quiz (Quiz Total)","Points Scored: State Quiz (Quiz Total)","Points Total Possible: State
# Quiz (Quiz Total)","Plagiarism Flag Status: State Quiz (Quiz Total)","Plagiarism Flag Evidence: State Quiz (Quiz
# Total)","Original Assessment Grade: MP 5 - Scheme (MPs) (Passing Threshold: 0.8)","Assessment Grade Override: MP 5 -
# Scheme (MPs) (Passing Threshold: 0.8)","Submission Time (UTC): MP 5 - Scheme (MPs)","Item Weighting (Percentage): MP 5 -
# Scheme (MPs)","Points Scored: MP 5 - Scheme (MPs)","Points Total Possible: MP 5 - Scheme (MPs)","Plagiarism Flag Status:
# MP 5 - Scheme (MPs)","Plagiarism Flag Evidence: MP 5 - Scheme (MPs)","original assessment grade: prolog quiz (quiz
# total) (passing threshold: 0.8)","assessment grade override: prolog quiz (quiz total) (passing threshold:
# 0.8)","Submission Time (UTC): Prolog Quiz (Quiz Total)","Item Weighting (Percentage): Prolog Quiz (Quiz Total)","Points
# Scored: Prolog Quiz (Quiz Total)","Points Total Possible: Prolog Quiz (Quiz Total)","Plagiarism Flag Status: Prolog Quiz
# (Quiz Total)","Plagiarism Flag Evidence: Prolog Quiz (Quiz Total)","Original Assessment Grade: Exam 2 - Password Quiz
# (Passing Threshold: 1.0)","Assessment Grade Override: Exam 2 - Password Quiz (Passing Threshold: 1.0)","Submission Time
# (UTC): Exam 2 - Password Quiz","Item Weighting (Percentage): Exam 2 - Password Quiz","Points Scored: Exam 2 - Password
# Quiz","Points Total Possible: Exam 2 - Password Quiz","Plagiarism Flag Status: Exam 2 - Password Quiz","Plagiarism Flag
# Evidence: Exam 2 - Password Quiz","Original Assessment Grade: Exam 2 (Passing Threshold: 0.8)","Assessment Grade
# Override: Exam 2 (Passing Threshold: 0.8)","Submission Time (UTC): Exam 2","Item Weighting (Percentage): Exam 2","Points
# Scored: Exam 2","Points Total Possible: Exam 2","Plagiarism Flag Status: Exam 2","Plagiarism Flag Evidence: Exam
# 2","Original Assessment Grade: Pragmatics Quiz (Quiz Total) (Passing Threshold: 0.8)","Assessment Grade Override:
# Pragmatics Quiz (Quiz Total) (Passing Threshold: 0.8)","Submission Time (UTC): Pragmatics Quiz (Quiz Total)","Item
# Weighting (Percentage): Pragmatics Quiz (Quiz Total)","Points Scored: Pragmatics Quiz (Quiz Total)","Points Total
# Possible: Pragmatics Quiz (Quiz Total)","Plagiarism Flag Status: Pragmatics Quiz (Quiz Total)","Plagiarism Flag
# Evidence: Pragmatics Quiz (Quiz Total)","Original Assessment Grade: MP 6 - Type Inferencer (MPs) (Passing Threshold:
# 0.8)","Assessment Grade Override: MP 6 - Type Inferencer (MPs) (Passing Threshold: 0.8)","Submission Time (UTC): MP 6 -
# Type Inferencer (MPs)","Item Weighting (Percentage): MP 6 - Type Inferencer (MPs)","Points Scored: MP 6 - Type
# Inferencer (MPs)","Points Total Possible: MP 6 - Type Inferencer (MPs)","Plagiarism Flag Status: MP 6 - Type Inferencer
# (MPs)","Plagiarism Flag Evidence: MP 6 - Type Inferencer (MPs)","Original Assessment Grade: Final Project (Passing
# Threshold: 0.8)","Assessment Grade Override: Final Project (Passing Threshold: 0.8)","Submission Time (UTC): Final
# Project","Item Weighting (Percentage): Final Project","Points Scored: Final Project","Points Total Possible: Final
# Project","Plagiarism Flag Status: Final Project","Plagiarism Flag Evidence: Final Project","Original Assessment Grade:
# Final Exam - Password Quiz (Passing Threshold: 1.0)","Assessment Grade Override: Final Exam - Password Quiz (Passing
# Threshold: 1.0)","Submission Time (UTC): Final Exam - Password Quiz","Item Weighting (Percentage): Final Exam - Password
# Quiz","Points Scored: Final Exam - Password Quiz","Points Total Possible: Final Exam - Password Quiz","Plagiarism Flag
# Status: Final Exam - Password Quiz","Plagiarism Flag Evidence: Final Exam - Password Quiz","Original Assessment Grade:
# Final Exam (Passing Threshold: 0.8)","Assessment Grade Override: Final Exam (Passing Threshold: 0.8)","Submission Time
# (UTC): Final Exam","Item Weighting (Percentage): Final Exam","Points Scored: Final Exam","Points Total Possible: Final
# Exam","Plagiarism Flag Status: Final Exam","Plagiarism Flag Evidence: Final Exam","Letter Grade","Course Grade","Course
# Passed","Completed with CC","Present Grade","Graded Assignment Group Grade: Quiz Total","Graded Assignment Group Weight:
# Quiz Total","Graded Assignment Group Grade: MPs","Graded Assignment Group Weight: MPs","Forum Posts"
