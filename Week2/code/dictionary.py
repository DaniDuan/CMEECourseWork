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

