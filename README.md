# LexicalAnalyzer

## Formatul parser.automata:
liniile care incep cu # sunt considerate comentarii

### Tranzitii

pana la prima linie goala sunt descrise tranzitiile in urmatoarele feluri:

#### stare_sursa caracter_de_tranzitie stare_destinatie
reprezinta o tranzitie simpla de automat
#### stare_sursa default stare_destinatie

default reprezinta un keyword si este folosit pentru a consemna faptul ca din stare_sursa se poate trece in stare destinatie
cu orice caracter

#### stare_sursa except caracter

except reprezinta un keyword si este folosit pentru starile care au default setat pentru a consemna faptul ca automatul fiind
in starea sursa trebuie sa se blocheze cu caracterul "caracter"

__s-a folosit keyword-ul endline pentru caracterul \n__

### Stari

Dupa prima linie goala este specificata starea de start precum si starile finale impreuna cu tipul acestora
