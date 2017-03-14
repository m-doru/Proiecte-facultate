f = open('processedData.out', 'r')

nrLines = 0

while(f.readline()):
    nrLines += 1

print(nrLines)
