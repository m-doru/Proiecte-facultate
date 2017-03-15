from collections import OrderedDict


class Token:
    VALUES = OrderedDict()

    def __init__(self, type, value):
        self.type = type 

        if value in Token.VALUES:
            self.value = Token.VALUES[value]
        else:
            Token.VALUES[value] = len(Token.VALUES)+1

    @property
    def value(self):
        if self.type == Token.TYPE['keyword']:
            return Token.KEYWORDS.keys()[self.value]
        return Token.VALUES.keys()[self.value]
