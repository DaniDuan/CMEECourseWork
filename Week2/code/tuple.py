birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# 
# A nice example output is:
# 
# Latin name: Passerculus sandwichensis
# Common name: Savannah sparrow
# Mass: 18.7
# ... etc.

# Hints: use the "print" command! You can use list comprehensions!



#!/usr/bin/env python3

"""Printing birds latin name, common name and mass on separated lines"""

__appname__='tuple.py'
__author__='Danica (d.duan20@imperial.ac.uk)'
__version__='0.0.1'
__license__=''

## imports ##
import sys

## constants ##
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

## functions ##
def main(argv):
    for row in birds:
        print("Latin name: ", row[0])
        print("Common name: ", row[1])
        print("mass: ", row[2])

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
