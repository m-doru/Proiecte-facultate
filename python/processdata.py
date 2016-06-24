import re
f = open('data.in', 'r')

data = f.read()

f.close()

g = open('processedData.out', 'w')

m = re.findall('<B.*?>(.+?)</B>', data)

dataSets = []

for line in m:
    strnumbers = line.split(',')
   
    if len(strnumbers) != 20:
        continue

    numbers = [int(nr) for nr in strnumbers]
    numbers.sort()
    
    dataSets.append(numbers)

dataSets.sort()

for numbers in dataSets:
    for nr in numbers:
        g.write(str(nr))
        g.write(' ')
    g.write('\n')
