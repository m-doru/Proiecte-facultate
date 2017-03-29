from lexicalAnalyzer import LexicalAnalyzer
lexicalAnalyzer = LexicalAnalyzer('input.in', 'parser.automata')

while True:
    token = lexicalAnalyzer.get_next_token()

    if token is None:
        break

    print(token)
