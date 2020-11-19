""" Use the subprocess.os module to get a list of files and directories from a certain path,
 with or without a given condition"""

import subprocess

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions


#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:
        
# Get the user's home directory.
Path = "../../"

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(Path):
    for f in files:
        if f.startswith("C"):
            FilesDirsStartingWithC.append(f)
    if dir.split("/")[-1].startswith("C"):
        FilesDirsStartingWithC.append(dir.split("/")[-1])
    for sub in subdir:
        if sub.startswith("C"):
            FilesDirsStartingWithC.append(sub)

print(FilesDirsStartingWithC)

#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:

FilesDirsStartingWithc = []


for (dir, subdir, files) in subprocess.os.walk(Path):
    for filename in files: 
        if filename.lower().startswith("c"):
            FilesDirsStartingWithc.append(filename)
    if dir.split("/")[-1].lower().startswith("c"):
        FilesDirsStartingWithc.append(dir.split("/")[-1])
    for subdirectory in subdir:
        if subdirectory.lower().startswith("c"):
            FilesDirsStartingWithc.append(subdirectory)

print(FilesDirsStartingWithc)

#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:

DirsStartingWithc = []


for (dir, subdir, files) in subprocess.os.walk(Path):
    if dir.split("/")[-1].lower().startswith("c"):
        DirsStartingWithc.append(dir.split("/")[-1])
    for subdirectory in subdir:
        if subdirectory.lower().startswith("c"):
            DirsStartingWithc.append(subdirectory)

print(DirsStartingWithc)
