from enum import Enum

class Type(Enum):
    KEYWORD = 1
    IDENTIFIER = 2
    STRING_LITERAL = 3
    PUNCTUATOR = 4
    CONSTANT_INTEGRAL_DEC = 5
    CONSTANT_INTEGRAL_OCT = 6
    CONSTANT_INTEGRAL_HEX = 7
    CONSTANT_FLOAT_DEC = 8 
    CONSTANT_FLOAT_OCT = 9
    CONSTANT_FLOAT_HEX = 10
    INCLUDE_HEADER = 11
    NONE = 12

