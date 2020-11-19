"""Regular expressions (regex) are a tool to find patterns (not just a particular sequence of characters) in strings. """

import re
my_string = "A given string."
match = re.search(r'\s', my_string) #\s: any whitespace character
print(match)
match.group()

match = re.search(r"\d", my_string) #\d: decimal digit
print(match)

MyStr = 'an example'
match = re.search(r'\w*\s', MyStr) #\w: a single "word" character
if match: 
    print('found a match:', match.group())
else:
    print('did not find a match')

match = re.search(r'2', 'it takes 2 to tango')
match = re.search(r'\d', "it takes 2 to tango") #\d: a numeric (integer) character
match = re.search(r'\d.*', 'it takes 2 to tango')
# .: any character except line break
# *: Match zero or more occurrences of the character or pattern that precedes it.
match = re.search(r'\s\w{1,3}\s', "once upon a time") # {}: Match exactly the specified number of occurrences
match = re.search(r'\s\w*$', 'once upon a time') # $: Match the end of a string
re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O'). group()
re.search(r'^\w*.*\s', 'once upon a time'). group() # ^: at the start of a longer string
re.search(r'^\w*.*?\s', 'once upon a time'). group() # ?: the preceding pattern element zero or one times
re.search(r'<.+>', 'This is a <EM>first</EM> test'). group()
# +: 1 or more occurrences of the character or pattern that precedes it
re.search(r'<.+?>', 'This is a <EM>first</EM> test'). group()
re.search(r'\d*\.?\d*', '1432.75+60.22i'). group()
re.search(r'[AGTC]+', 'the sequence ATTCGT'). group()
re.search(r'\s+[A-Z]\w+\s*\w+', "The bird-shit frog's name is Theloderma asper."). group()

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r'[\w\s]+,\s[\w\.@]+,\s[\w\s]+', MyStr)
match.group()

MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+", MyStr)
match.group()

#Practical: some regexercises
re.search(r'[\w\s\W]+,', "a?b,sss").group()

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r'[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s]+', MyStr)
match.group()

match = re.search(r'([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)', MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))
    
emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr) #re.findall: Like re.search, but returns a list of all matches.
for email in emails:
    print(email)



f = open('../data/TestOaksData.csv', 'r')
found_oaks = re.findall(r"Q[\w\s].*\s", f.read())
found_oaks

MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a.academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a.academic@imperial.ac.uk, Some other stuff thats even more boring"
found_matches = re.findall(r'([\w\s]+),\s([\w\.-]+@[\w\.-]+)', MyStr)
found_matches

for item in found_matches:
    print(item)


########Extracting text from webpages
import urllib3
conn = urllib3.PoolManager() #open a connection
r = conn.request("GET", "https://www.imperial.ac.uk/silwood-park/academic-staff/")
webpage_html = r.data #read webpage contents
type(webpage_html)

My_Data = webpage_html.decode()
#print(My_Data)
pattern = r"Dr\s+\w+\s+\w+"
regex = re.compile(pattern)
for match in regex.finditer(My_Data):
    print(match.group())

#####Improvement####
pattern = r"Dr\s+\w+\s+\w+|Prof\s+\w+\s+\w+|Professor\s+[^io]\w+\s\w+" #1
regex = re.compile(pattern)
for match in regex.finditer(My_Data):
    print(match.group())


New_Data = re.sub(r'\t'," ", My_Data) #replace tabs with spaces
# print(New_Data)

