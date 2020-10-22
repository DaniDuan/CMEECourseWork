#!/usr/bin/env python3

""" Excercise file on python loops and conditions"""

for j in range(12):
    if j % 3 == 0:
        print('Hello')

for j in range(15):
    if j % 5 == 3:
        print('Hello')
    elif j % 4 == 3:
        print('Hi')

z = 0
while z !=15:
    print('Hello')
    z = z + 3

z = 12
while z < 100: 
    if z == 31: 
        for k in range(7):
            print('Hello')
    elif z == 18:
        print('Hello')
    z = z + 1