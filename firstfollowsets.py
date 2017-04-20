LAMBDA = 'lambda'
END_SYMBOL = '$'

def compute_follow_set(productions, start_symbol):
    follow = {}
    first_set = compute_first_set(productions)
    for nonterm in productions:
        follow[nonterm] = set()

    follow[start_symbol].add(END_SYMBOL)

    changed = True

    while(changed):
        prev_follow = follow.copy()

        for symb in productions:
            for nonterm in productions:
                for deriv in productions[nonterm]:
                    if symb not in deriv:
                        continue

                    pos = deriv.index(symb)
                    if pos == len(deriv)-1:
                        follow[symb] = follow[symb].union(follow[nonterm])
                        continue
                    m = compute_first_set_multiple_simbols(deriv[pos+1:], compute_first_set(productions))
                    if END_SYMBOL in m:
                        m.discard(END_SYMBOL)
                        follow[symb] = follow[symb].union(m).union(follow[nonterm])
                    else:
                        follow[symb] = follow[symb].union(m)

        changed = not prev_follow == follow

    return follow

def compute_first_set(productions):
    first = {}
    for nonterm in productions:
        first[nonterm] = set()

    changed = True

    while(changed):
        prev_first = first.copy()

        for nonterm in productions:
            for deriv in productions[nonterm]:
                #we take care of the terminal simbols
                for elem in deriv:
                    if elem not in productions and elem not in first and elem != LAMBDA:
                        first[elem] = set([elem])

                if deriv == [LAMBDA]:
                    first[nonterm].add(END_SYMBOL)
                elif deriv[0] not in productions:
                    first[nonterm].add(deriv[0])
                else:
                    w = first[deriv[0]]
                    i = 1
                    while i < len(deriv) and END_SYMBOL in first[deriv[i-1]]:
                        w = w.union(first[deriv[i]])
                        i += 1

                    if (i < len(deriv) and END_SYMBOL in first[deriv[i]])\
                            or (i == len(deriv) and END_SYMBOL not in first[deriv[i-1]]):
                            w.discard(END_SYMBOL)
                    first[nonterm] = first[nonterm].union(w)

        changed = not prev_first == first

    return first

def compute_first_set_multiple_simbols(simbols, first_of):
    if len(simbols) == 0:
        w = set([LAMBDA])
    else:
        w = first_of[simbols[0]].copy()
        i = 1
        while i < len(simbols) and LAMBDA in first_of[simbols[i]]:
            w = w.union(first_of[simbols[i]])
            i += 1
        if LAMBDA in first_of[simbols[-1]]:
            w.discard(LAMBDA)

    return w