#!/usr/bin/env python3
"""Importance of the return directive """

"""creating list for modify"""
def modify_list_1(some_list): 
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)

modify_list_1(my_list)

print('after, my_list =', my_list)


"""creating list for modify"""

def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)

print('after, my_list = ', my_list)

"""creating list for modify"""

def modify_list_3(some_list):
    print('got',some_list)
    some_list.append(4)
    print('changed to', some_list)

my_list = [1, 2, 3]

print('Before, my_list =', my_list)

modify_list_3(my_list)

print('After, my_list =', my_list)

