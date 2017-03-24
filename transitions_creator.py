import string

graphic_characters = ['!', '\"', '#', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.','/', ':',
                      ';', '<','=', '?', '[', '\\',']','^', '_', '{', '|','}', '~']
hexa = ['a','b','c','d','e','f','A','B','C','D','E','F']
octa = ['0','1','2','3','4','5','6','7']
letters =  graphic_characters
states = [('header_name_ghilimele_first', 'header_name_ghilimele')]

'''
states =[('id_U', 'id_U1')]
for i in range(1,7):
    start = 'id_U' + str(i)
    destination = 'id_U' + str((i+1))
    states.append((start, destination))
states.append(('id_U7', 'parse_identifier'))
'''

with open('transitions', 'w') as f:
    for (start, destination) in states:
        for letter in letters:
            if letter == 'litere_mici':
                for letter in list(string.ascii_lowercase):
                    f.write(start + ' ' + letter + ' ' + destination + '\n')
            elif letter == 'litere_mari':
                for letter in list(string.ascii_uppercase):
                    if not letter == 'L':
                        f.write(start + ' '+ letter + ' ' + destination + '\n')
            elif letter == 'cifre':
                for cif in list(string.digits):
                    f.write(start + ' ' + cif + ' ' + destination + '\n')
            elif letter == 'hexa':
                for let in hexa:
                    f.write(start + ' ' + let + ' ' + destination + '\n')
            else:
                f.write(start + ' ' + letter + ' ' + destination + '\n')
