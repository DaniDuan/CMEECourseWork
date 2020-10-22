#!/usr/bin/env python3

"""test for python input and output """
##################
# FILE INPUT
##################
# Open a file for reading
f = open('../data/test.txt', 'r')
# use implicit for loop
# if the object is a file, python will cycle over lines
for line in f:
        print(line)
f.close()


f = open('../data/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)
        
f.close()