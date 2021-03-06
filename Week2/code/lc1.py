#!/usr/bin/env python3
"""Creating lists from *birds* data upon requirements using comprehension and loops."""


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

#Method 1
Latin_names = [ i[0] for i in birds ]
Common_names = [i[1] for i in birds]
Mean_body_masses = [i[2] for i in birds]

#Method 2
#Latin_names = [x for x, y, z in birds]
#Common_names = [y for x, y, z in birds]
#Mean_body_masses = [z for x, y, z in birds]

print(Latin_names)
print(Common_names)
print(Mean_body_masses)





# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 
Latin_names = []
Common_names = []
Mean_body_masses = []

#Method 1
for i in birds:
    Latin_names.append(i[0])
    Common_names.append(i[1])
    Mean_body_masses.append(i[2])


#Method 2
#for x, y, z in birds:
#    Latin_names.append(x)
#    Common_names.append(y)
#    Mean_body_masses.append(z)

print(Latin_names)
print(Common_names)
print(Mean_body_masses)