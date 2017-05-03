with open('data.in', 'r') as fin, open('data.out', 'w') as fout:
    words = fin.readlines()
    fout.write('[')
    for word in words:
        fout.write("'{}',".format(word.strip()))

    fout.write(']')
