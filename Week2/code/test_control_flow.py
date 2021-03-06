#!/usr/bin/env python3

"""Description of this program or application.
You can use several lines """

__appname__ = 'test_ontrol_flow.py'
__author__ = 'Danica (d.duan20@imperial.ac.uk)'
__version__= '0.0.1'
__license__ = "License for this code/program"

## imports ##
import sys # module to interface our program with the operating system
import doctest

## constants ##

def even_or_odd(x=0):
    """Find whether a number x is even or odd.

    >>> even_or_odd(10)
    '10 is Even!'

    >>> even_or_odd(5)
    '5 is Odd!'

    whenever a float is provided, then the closest integer is used:
    >>> even_or_odd(3.2)
    '3 is Odd!'

    in case of negative numbers, positve is taken:
    >>> even_or_odd(-2)
    '-2 is Even!'
    """
    #Define function to be tested
    if x % 2 == 0:
        return "%d is Even!" % x
    return "%d is Odd!" % x



## functions ##
def main(argv):
    """Main entry point of the program"""

    print(even_or_odd(22))
    print(even_or_odd(33))
    return 0



if __name__ == "__main__": 
   """Makes sure the "main" function is called from the command line"""
   status = main(sys.argv)
   sys.exit(status)

doctest.testmod() # To run with embedded tests