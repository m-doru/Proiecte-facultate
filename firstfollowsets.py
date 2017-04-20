LAMBDA = 'lambda'

def first_set(symbol, productions, first_all):
    # daca simbolul este terminal
    if not symbol in productions:
        return set([symbol])

    first = first_all[symbol]
    results = productions[symbol]

    changed = True
    while(changed):
        changed = False
        for res in results:
            if res == [LAMBDA]:
                crt_first = set([LAMBDA])
                if not crt_first <= first:
                    changed = True
                    first = first.union(crt_first)
                continue

            if len(res) == 1:
                if len(first[res[0]]) != 0:
                    crt_first = first[res[0]]
                    if not crt_first <= first:
                        changed = True
                        first = first.union(crt_first)
                else:
                    crt_first = first_set(res[0], productions, first)
                    if not crt_first <= first:
                        changed = True
                        first = first.union(crt_first)
            else:
                crt_first = first_set_multiple_symbols(res, productions)
                if not crt_first <= first:
                    changed = True
                    first = first.union(crt_first)

    return first

def first_set_multiple_symbols(symbols, productions):
    if len(symbols) == 0:
        return set(LAMBDA)

    sym = symbols[0]

    if sym in productions:
        derivations = productions[sym]
    else:
        return set(sym)

    if not LAMBDA in derivations:
        return first_set(sym, productions)

    return first_set(sym, productions)\
        .union(first_set_multiple_symbols(symbols[1:], productions))

def follow_set(symbol, productions, start_symbol):
    if symbol == start_symbol:
        return {[LAMBDA]}

    follow = set()
    for nonterm in productions:
        derivations = productions[nonterm]
        for deriv in derivations:
            if symbol in deriv:
                pos = deriv.index(symbol)
                if pos == len(deriv)-1:
                    follow = follow.union(follow_set(nonterm, productions, start_symbol))
                else:
                    first_next = first_set_multiple_symbols(deriv[pos+1:], productions)
                    if LAMBDA in list(first_next):
                        first_next.discard(LAMBDA)
                        follow = follow.union(first_next)
                        follow = follow.union(follow_set(nonterm, productions, start_symbol))
                    else:
                        follow = follow.union(first_next)

    return follow
