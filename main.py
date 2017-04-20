import firstfollowsets
from scanner import Scanner

FIRST = None
FOLLOW = None
END_SYMBOL = '$'
SCAN = None
PRODUCTIONS = None
START_SYMBOL = None

def load_grammar(filename):
    productions = {}

    with open(filename, 'r') as f:
        lines = f.readlines()
        start_line = 0
        while(start_line < len(lines) and lines[start_line][0] == '#'):
            start_line += 1
        start_symbol = lines[start_line].split('->')[0].strip()
        for line in lines:
            if line[0] == '#':
                continue
            production = line.split('->')
            nonterminal = production[0].strip()

            if not nonterminal in productions:
                productions[nonterminal] = []

            derivation = production[1].strip().split(' ')

            productions[nonterminal].append(derivation)

    return productions, start_symbol

def nonterm_fct(nonterm):
    for deriv in PRODUCTIONS[nonterm]:
        first_of_el = firstfollowsets.compute_first_set_multiple_simbols(deriv, FIRST)
        if END_SYMBOL not in first_of_el:
            sd = first_of_el
        else:
            first_of_el.discard(END_SYMBOL)
            sd = first_of_el.union(FOLLOW[nonterm])

        if SCAN.token in sd:
            print(nonterm, '->', deriv)
            parse(deriv)
            return
    print("Eroare la neterminalul ", nonterm)

def parse(simbols):
    if simbols[0] not in PRODUCTIONS:
        SCAN.scan()
        check(simbols[1:])
    else:
        nonterm_fct(simbols[0])
        check(simbols[1:])

def check(simbols):
    if simbols[0] not in PRODUCTIONS:
        if SCAN.token == simbols[0]
            SCAN.scan()
        else:
            print("Eroare la scanarea tokenlui ", SCAN.token, " cu derivarea ", simbols)

        check(simbols[1:])
    else:
        parse(simbols)

def main():
    PRODUCTIONS,START_SYMBOL = load_grammar('grammar.config')

    FIRST = firstfollowsets.compute_first_set(PRODUCTIONS)
    FOLLOW = firstfollowsets.compute_follow_set(PRODUCTIONS, START_SYMBOL)

    SCAN = Scanner('doru')

    nonterm_fct(START_SYMBOL, PRODUCTIONS)

    if SCAN.token is not None:
        print("Eroare la parsare. Nu s-au parsat toate token-urile")
if __name__ == '__main__':
    main()