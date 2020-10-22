#!/usr/bin/env python3

"""aligns two DNA sequences, returns the best match,
 and count the “score” as total of number of bases matched."""

__appname__ = 'align_seqs.py'
__author__ = 'Danica (d.duan20@imperial.ac.uk)'
__version__= '0.0.1'
__license__ = ""


## Imports ##
import csv
import sys


## Constants ##

## Functions ##
"""Two example sequences to match"""
def file_import():
    f = open('../data/sample_sequence.csv','r')
    csvread = csv.reader(f)
    for row in csvread:
        seq1 = row[0]
        seq2 = row[1]
    f.close()
    return seq1, seq2

"""Assign the longer sequence s1, and the shorter to s2
l1 is length of the longest, l2 that of the shortest"""
def swap_lengths(seq1, seq2): 
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    return s1, s2, l1, l2



"""A function that computes a score by returning the number of matches starting
from arbitrary startpoint (chosen by user)"""
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

"""now try to find the best match (highest score) for the two sequences"""
def best_match(s1, s2, l1, l2):
    my_best_align = None
    my_best_score = -1

    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)

    return my_best_align, my_best_score

"""output file"""
def file_output(my_best_align, my_best_score):
    g = open('../results/output_sample_sequence.txt','w') 
    g.write('My best alignment is ' + str(my_best_align) + '\n')
    g.write('My best score is ' + str(my_best_score) + '\n')
    g.close()
    return 0

def main(argv): 
    """Main entry point of the program"""
    seq1, seq2 = file_import()
    s1, s2, l1, l2 = swap_lengths(seq1, seq2)
    my_best_align, my_best_score = best_match(s1, s2, l1, l2)
    file_output(my_best_align, my_best_score)
    return 0

if __name__ == "__main__": 
    """Makes sure the "main" function is called from the command line"""
    status = main(sys.argv)
    sys.exit(status)
