import my_token
import type
from automata import Automata

class Scanner:

    SKIPABLE_CHARACTERS = [' ', '\t', '\n', '\r']
    NEW_LINE = ['\n', '\r\n']
    
    def __init__(self, input_file_path, automata_config_file_path):
        self.automata = Automata(automata_config_file_path)
        self.filePath = input_file_path
        self.position = 0
        self.input = []
        self._read_input_file()

    def get_next_token(self):
        self.automata.reset()

        while(self.position < len(self.input) and (self._skip_skippable_characters() or
                  self._detect_and_skip_comments())):
            pass

        tokenValue = []
        while self.position < len(self.input) and\
                self.automata.try_transition(self.input[self.position]):

            tokenValue.append(self.input[self.position])

            # advance the automata
            self.automata.make_transition(tokenValue[-1])

            self.position += 1

        if self.automata.in_final_state():
            state = self.automata.current_state

            return my_token.Token(state.type, ''.join(tokenValue))

        # otherwise I try to recover from error if a final state was encountered along the way
        if self.automata.encountered_final_state:
            print('Recovering after blocked in state ' + str(self.automata.current_state) + ' and processed ' + ''.join(
                tokenValue))
            while not self.automata.in_final_state():
                self.automata.reverse()
                self.position -= 1
                tokenValue = tokenValue[:-1]

            tokenStringValue= ''.join(tokenValue)

            return my_token.Token(self.automata.current_state.type, tokenStringValue)

        if len(tokenValue) > 0:
            # if the automata was not able to make a transition from current state and current letter we raise an error
            if self.position < len(self.input):
                msg = 'Automata crashed in state ' + str(self.automata.current_state) + ' after processing the string "' \
                       + ''.join(tokenValue) + '" and trying to make a transition with ' + self.input[self.position]
                raise Exception(msg)
            else:
                msg = 'Automata crashed in state ' + str(self.automata.current_state) + ' after processing the string "' \
                       + ''.join(tokenValue) + '" and trying to make a transition with ' + self.input[self.position-1]
                raise Exception(msg)
        else:
            # got to the end of file
            return None
    def _skip_to_newline(self):
        while(self.position < len(self.input) and self.input[self.position] not in self.NEW_LINE):
            self.position += 1

    def _skip_skippable_characters(self):
        flag = False

        # we check if the first character is skipable in order to not set the flag to TRUE at every while's iteration
        if self.input[self.position] in self.SKIPABLE_CHARACTERS:
            flag = True

        while(self.position < len(self.input) and self.input[self.position] in self.SKIPABLE_CHARACTERS):
            self.position += 1

        return flag
    
    def _detect_and_skip_comments(self):
        lineCommentEncountered = False
        multilineCommentEncountered = False
        if self.position < len(self.input)-1 and self.input[self.position] == '/' and\
                        self.input[self.position+1] == '/':
            lineCommentEncountered = True
            self._skip_to_newline()

        if not lineCommentEncountered and self.input[self.position] == '/' and self.input[self.position+1] == '*':
            multilineCommentEncountered = True
            self.position += 2

            while(self.position < len(self.input)-2) and\
                    not (self.input[self.position] == '*' and self.input[self.position+1] == '/'):
                self.position += 1
        
        if multilineCommentEncountered and self.input[self.position] == '*' and self.input[self.position+1] == '/':
            self.position += 2

        return lineCommentEncountered or multilineCommentEncountered

    def _read_input_file(self):
        with open(self.filePath, 'r') as inputFile:
            self.input = inputFile.read()
