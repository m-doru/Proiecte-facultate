import firstfollowsets

def load_grammar(filename):
    productions = {}

    with open(filename, 'r') as f:
        lines = f.readlines()
        start_symbol = lines[0].split('->')[0].strip()
        for line in lines:
            production = line.split('->')
            nonterminal = production[0].strip()

            if not nonterminal in productions:
                productions[nonterminal] = []

            derivation = production[1].strip().split(' ')

            productions[nonterminal].append(derivation)

    return productions, start_symbol

def compute_first_sets(productions):
    changed = True
    first = {}
    for non_term in productions:
        first[non_term] = set()
    while(changed):
        changed = False
        for non_term in productions:
            crt_first = firstfollowsets.first_set(non_term, productions, first)
            # if crt_first is not a subset of first[non_term]
            if not crt_first <= first[non_term]:
                first[non_term] = first[non_term].union(crt_first)
                changed = True
    return first

def compute_follow_sets(productions, start_symbol):
    changed = True
    follow = {}
    for non_term in productions:
        follow[non_term] = set()
    while(changed):
        changed = False
        for non_term in productions:
            crt_follow = follow

def main():
    productions,start_symbol = load_grammar('grammar.config')
    first = compute_first_sets(productions, start_symbol)

    follow = {}

    for key in first:
        print(key, ' ', first[key])

    for key in follow:
        print(key, ' ', follow[key])

if __name__ == '__main__':
    main()