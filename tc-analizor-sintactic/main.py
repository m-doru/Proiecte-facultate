import firstfollowsets
import sys
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
    global PRODUCTIONS
    global END_SYMBOL
    global FIRST
    global FOLLOW
    global SCAN
    for deriv in PRODUCTIONS[nonterm]:
        first_of_el = firstfollowsets.compute_first_set_multiple_simbols(deriv, FIRST)
        if END_SYMBOL not in first_of_el:
            sd = first_of_el
        else:
            first_of_el.discard(END_SYMBOL)
            sd = first_of_el.union(FOLLOW[nonterm])

        if SCAN.token in sd:
            print(nonterm, '->', "".join(deriv))
            parse(deriv)
            return
    print("Eroare la neterminalul ", nonterm, " si parsarea ", SCAN.token)
    sys.exit(0)

def parse(simbols):
    global PRODUCTIONS
    global SCAN
    if simbols[0] not in PRODUCTIONS:
        if simbols[0] != 'lambda':
            SCAN.scan()
    else:
        nonterm_fct(simbols[0])

    check(simbols[1:])

def check(simbols):
    if len(simbols) == 0:
        return
    global PRODUCTIONS
    global SCAN
    if simbols[0] not in PRODUCTIONS:
        if SCAN.token == simbols[0]:
            SCAN.scan()
        else:
            print("Eroare la scanarea tokenlui ", SCAN.token, " cu derivarea ", simbols)
            sys.exit(0)

        check(simbols[1:])
    else:
        parse(simbols)

def main():
    global PRODUCTIONS
    global FIRST
    global FOLLOW
    global SCAN
    global START_SYMBOL
    PRODUCTIONS,START_SYMBOL = load_grammar('grammar.config')

    FIRST = firstfollowsets.compute_first_set(PRODUCTIONS)
    FOLLOW = firstfollowsets.compute_follow_set(PRODUCTIONS, START_SYMBOL)

    SCAN = Scanner('(a+a)')

    nonterm_fct(START_SYMBOL)

    if SCAN.token is not '$':
        print("Eroare la parsare. Nu s-au parsat toate token-urile")
    else:
        print("Cuvantul ", SCAN._tokens, " este acceptat de gramatica")
if __name__ == '__main__':
    main()
