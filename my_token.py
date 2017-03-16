from collections import OrderedDict
import type

class Token:
    VALUES = OrderedDict()

    def __init__(self, type, value):
        self.type = type 
        self.val = None

        if value in Token.VALUES:
            self.val = Token.VALUES[value]
        else:
            Token.VALUES[value] = len(Token.VALUES)+1
            self.val = Token.VALUES[value]

    @property
    def value(self):
        if self.type == type.Type['KEYWORD']:
            return Token.KEYWORDS.keys()[self.val]
        return Token.VALUES.keys()[self.val]


    def __str__(self):
        return str(self.type) + ' : ' + str(self.value)