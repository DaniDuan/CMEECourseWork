import re

# Read the file (using a different, more python 3 way, just for fun!)
with open('../data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string

# Now extend this script so that it captures the Kingdom, Phylum and Species
# name for each species and prints it out to screen neatly.


pattern = r"Kingdom\s\w*|Phylum\s\w*|Species\s\w*\s\w*"
regex = re.compile(pattern)
for match in regex.finditer(text):
    print(match.group())

#Long version
# pattern_kingdom = r"Kingdom[\w\s]+\s+\W[\s\w]+,[\s\w]+,[\s\w]+?\s"
# regex_Kingdom = re.compile(pattern_kingdom)
# for match_k in regex_Kingdom.finditer(text):
#     print(match_k.group())

# pattern_phylum = r"Phylum[\s\w]+\s+\W[\s\w]+,[\s\w]+,[\s\w]+?\s"
# regex_phylum = re.compile(pattern_phylum)
# for match_p in regex_phylum.finditer(text):
#     print(match_p.group())

# pattern_species = r"Species[\s\w]+\([\s\w]+,[\s\d]+\)\s\W\s\w+\W[\s\w]+,[\s\w]+,\s[\w\s]{18}|Species[\s\w]+\([\s\w]+,[\s\d]+\)\s\W\s\w+-\w+\s\w+"
# regex_species = re.compile(pattern_species)
# for match_s in regex_species.finditer(text):
#     print(match_s.group())




# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there
# are multiple ways to skin this cat! Your solution could involve multiple
# regular expression calls (slightly easier!), or a single one (slightly harder!)