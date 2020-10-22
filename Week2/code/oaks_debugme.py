#!/usr/bin/env python3

"""Output taxa that are oak trees from a list of species,
and debug the written function """

__appname__ = 'oaks_debugme.py'
__author__ = 'Danica (d.duan20@imperial.ac.uk)'
__version__= '0.0.1'
__license__ = "License for this code/program"

import csv
import sys
import doctest

# include the following two lines for doctest
f = open('../data/TestOaksData.csv','r')
taxa = csv.reader(f)

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus'

    >>> is_an_oak('Quercus robur')
    True

    >>> is_an_oak('Fraxinus excelsior')
    False

    >>> is_an_oak('Pinus sylvestris')
    False

    >>> is_an_oak('Quercus cerris')
    True

    >>> is_an_oak('Quercus petraea')
    True
    """
    # Define function to be tested
    # return name.lower().startswith('quercus')
    name = name.split(" ")
    if name[0] == 'Quercus':
        return True
    else:
        return False

def main(argv): 
    """Main entry point of the program"""

    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    csvwrite.writerow(["Genus", " species"])
    for row in taxa:
        if row[0].lower().strip() == "genus" and row[1].lower().strip() == "species":
            continue
        else: 
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])    
    return 0
    f.close()
    g.close()

if (__name__ == "__main__"):
    """Makes sure the "main" function is called from the command line"""

    status = main(sys.argv)

doctest.testmod() # To run with embedded tests