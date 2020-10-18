#!/usr/bin/env python3

"""aligns two DNA sequences, returns the best match,
 and count the “score” as total of number of bases matched."""

__appname__ = 'align_seqs_fasta.py'
__author__ = 'Danica (d.duan20@imperial.ac.uk)'
__version__= '0.0.1'
__license__ = ""


## Imports ##
import csv
import sys


## Constants ##

# Two example sequences to match

try: 
    a = sys.argv[1]
except: 
    a = "../data/seq1.csv"

try:
    b = sys.argv[2]
except:
    b = "../data/seq2.csv"


a1 = ""
b1 = ""

f1 = open(a,'r')
f2 = open(b,'r')
next(f1)
next(f2)
for line in f1.readlines():
    line = line.strip('\n')
    a1 = a1 + line
seq1 = a1

for line in f2.readlines():
    line = line.strip('\n')
    b1 = b1 + line
seq2 = b1

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths


## Functions ##

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
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

# now try to find the best match (highest score) for the two sequences
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

def main(argv): 
     g = open('../results/output_sample_sequence.txt','w') 
     g.write('My best alignment is ' + str(my_best_align) + '\n')
     g.write('My best score is ' + str(my_best_score) + '\n')
     return 0

if __name__ == "__main__": 
    status = main(sys.argv)
    sys.exit(status)
