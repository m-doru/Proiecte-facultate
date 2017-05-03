from scanner import Scanner
scanner = Scanner('input.in', 'parser.automata')
'''
stringurile merg pe mai multe linii doar daca are \
'''
while True:
    token = scanner.get_next_token()

    if token is None:
        break

    print(token)
