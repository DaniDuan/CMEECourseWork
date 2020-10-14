taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc.
#  OR,
# 'Chiroptera': {'Myotis lucifugus'} ... etc


#!/usr/bin/env python3

"""creating a dictionary called taxa_dic 
to map order names to sets of taxa """

__appname__='dictionary.py'
__author__='Danica (d.duan20@imperial.ac.uk)'
__version__='0.0.1'
__license__=''

## imports ##
import sys

## Constants ##
taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

## funtions ##
def main(argv):
        #First method:
        taxa_dic = {}
        for x, y in taxa:
                taxa_dic[y] = {x}
        print(taxa_dic)

        #Second method:
        taxa_dic = {y:x for x, y in taxa}
        print(taxa_dic)

        #Third method:
        taxa_dic = dict((y, x) for x, y in taxa)
        print(taxa_dic)

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)