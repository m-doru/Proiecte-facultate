import token
import automata

class LexialAnalyzer:
    KEYWORDS = ['auto','break','case','char','const','continue','default','do','double','else','enum','extern',
                'float','for','goto','if','inline','int','long','register','restrict','return','short','signed',
                'sizeof','static','struct','switch','typedef','union','unsigned','void','volatile','while','_Bool',
                '_Complex','_Imaginary']
    SKIPABLE_CHARACTERS = [' ', '\t', '\n', '\r']
    NEW_LINE = ['\n', '\r\n']
    
    def __init__(self, input_file_path):
        self._configure_automata()
        self.filePath = input_file_path
        self.position = 0
        self.input = []
        self._read_input_file()

    def get_next_token(self):
        while(self._skip_skippable_characters() or self._detect_and_skip_comments()):
            pass

        tokenValue = []
        while self.position > len(self.input) and\
                self.automata.try_advance(self.input[self.position]):

            tokenValue.append(self.input[self.position])

            # advance the automata
            self.automata.advance(tokenValue[-1])

            self.position += 1

        if self.automata.final_state:
            state = self.automata.current_state

            return token.Token(state.type, tokenValue)

        # otherwise I try to recover from error if a final state was encountered along the way
        if self.automata.encountered_final_state:
            while not self.automata.in_final_state():
                self.automata.reverse()
                self.position -= 1
                tokenValue = tokenValue[:-1]

            return token.Token(self.automata.current_state.type, tokenValue)
        # else we stop the analysis and raise an error
        if self.position < len(self.input):
            msg = 'Automata crashed in state ' + str(self.automata.current_state) + ' after processing the string ' \
                   + tokenValue
            raise Exception(msg)
        else:
            return None


    def _skip_to_newline(self):
        while(self.input[self.position] not in self.NEW_LINE):
            self.position += 1

    def _skip_skippable_characters(self):
        flag = False

        if self.input[self.position] in self.SKIPPABLE_CHARACTERS:
            flag = True

        while(self.input[self.position] in self.SKIPPABLE_CHARACTERS):
            self.position += 1

        return flag
    
    def _detect_and_skip_comments(self):
        flag = False
        if self.input[self.position] == '/' and self.input[self.position+1] == '/':
            flag = True
            self._skip_to_newline()

        if self.input[self.position] == '/' and self.input[self.position+1] == '*':
            flag = True
            self.position += 2

            while(not (self.input[self.position] == '*' and self.input[self.position] == '/') and self.position < len(self.input)-2):
                self.position += 1
        
        if self.input[self.position] == '*' and self.input[self.position] == '/':
            self.position += 2

        return flag

    def _read_input_file(self):
        inputFile = open(self.filePath)
        self.input = inputFile.read()
        inputFile.close()

