#!/usr/bin/env python3
"""Creating lists from *rainfall* data upon requirements using comprehension and loops."""

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

#Method 1
my_list = [i for i in rainfall if i[1] >100]

#Method 2
#my_list = [(x, y) for x, y in rainfall if y > 100]

print(my_list)
 



# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

#Method 1
months = [i[0] for i in rainfall if i[1] < 50]

#Method 2
#months = [x for x, y in rainfall if y < 50]

print(months)




# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

my_list = []
months = []

#Method 1
for i in rainfall:
    if i[1] > 100:
        my_list.append(i)
print(my_list)

for i in rainfall:
    if i[1] < 50:
        months.append(i[0])
print(months)


##Method 2
#for i in rainfall:
#    if i[1] > 100:
#        my_list.append(i)
#    elif i[1] < 50:
#        months.append(i[0])
#print(my_list)
#print(months)


#Method 3
#for x, y in rainfall:
#    if y > 100:
#        my_list.append((x, y))
#print(my_list)

#for x, y in rainfall:
#    if y < 50:
#        months.append(x)
#print(months)