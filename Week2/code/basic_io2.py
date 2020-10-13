###############
# FILE OUTPUT
###############
# Save the elements of a list into a file
list_to_save = range(100)
f = open('../sandbox/testout.txt','w')
for i in list_to_save: 
    f.write(str(i) + "\n") #Add a new line in the end

f.close()