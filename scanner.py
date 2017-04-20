class Scanner:
    def __init__(self, tokens):
        self._tokens = tokens
        self._token = tokens[0]
        self._index = 0

    @property
    def token(self):
        return self._token

    def scan(self):
        self._index += 1
        if self._index < len(self._tokens)
            self._token = self._tokens[self._index]
            return self._token
        self._token = None
        return None

