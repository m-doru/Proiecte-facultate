class Pair:
    def __init__(self, number):
        self.number = number
        self.freq = 0

def getFirstFive(pairs):
    pairs.sort(key = lambda pair: pair.freq)
    
    ps = pairs[-5:]

    return ps 

import re
f = open('data.in', 'r')

data = f.read()

m = re.findall('<B.*?>(.+?)</B>', data)

print(len(m))

table = [[Pair(i) for i in range(81)] for j in range(81)]


for line in m:
    
   

    numbers = line.split(',')

    for i in range(len(numbers)):
        for j in range(i+1, len(numbers)):
            try:
                a = int(numbers[i])
                b = int(numbers[j])
            except:
                break
            table[a][b].freq+=1
            table[b][a].freq+=1

f = open('statistici.txt', 'w')

for i in range(81): 
    ps = getFirstFive(table[i])
    output = (i, ' a aparut de cele mai multe ori cu ')
    f.write(str(output))
    f.write('\n')
    for p in ps:
        f.write(str((p.number, '-', p.freq)))
        f.write('\n')
    f.write('\n')
  
 


