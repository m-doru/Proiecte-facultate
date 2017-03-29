from collections import OrderedDict
import type

class Token:
    VALUES = OrderedDict()
    KEYWORDS = ['auto','break','case','char','const','continue','default','do','double','else','enum','extern',
                    'float','for','goto','if','inline','int','long','register','restrict','return','short','signed',
                    'sizeof','static','struct','switch','typedef','union','unsigned','void','volatile','while','_Bool',
                    '_Complex','_Imaginary']

    def __init__(self, type, value):
        self._type = type
        self.val = None

        # in order to be keen on memory, we will keep as values the position on ordered dict of the corresponding
        # string value. It was chosen the OrderedDict because it supplies fast lookup time and also it keeps
        # insertion order
        if value in Token.VALUES:
            self.val = Token.VALUES[value]
        else:
            Token.VALUES[value] = len(Token.VALUES)
            self.val = Token.VALUES[value]

    @property
    def value(self):
        keys = Token.VALUES.keys()
        return list(keys)[self.val]

    @property
    def type(self):
        if self.value in Token.KEYWORDS:
            return type.Type.KEYWORD
        else:
            return self._type

    def __str__(self):
        return str(self.type) + ' : ' + str(self.value)