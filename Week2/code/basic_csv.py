import csv
f = open('../data/testcsv.csv','r')
csvread = csv.reader(f)
temp = []
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print('the species is', row[0])

f.close()

f = open('../data/testcsv.csv', 'r')
g = open('../data/readcsv.csv', 'w')

csvread = csv.reader(f)
csvwrite = csv.writer(g)
for row in csvread: 
    print(row)
    csvwrite.writerow([row[0], row[4]])

f.close()
g.close()
