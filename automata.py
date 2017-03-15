class State:
    def __init__(self, name, type, is_final_state=False):
        self.transitions = {}
        self.name = name
        self.knownLetters = set()
        self.is_final_state = is_final_state
        self.type = type

    def __str__(self):
        return self.name

    def add_transition(self, letter, state):
        self.transitions[letter] = state
        self.knownLetters.add(letter)

    def try_transition(self, letter):
        return (letter in self.transitions)

    def get_transition_state(self, letter):
        if self.try_transition(letter):
            return self.transitions[letter]
        else:
            return None

class Automata:
    def __init__(self, config_file_path):
        initial_state = self._build_states_graph(config_file_path)
        self.initial_state = initial_state
        self.current_state = initial_state
        self.encountered_final_state = False
        self.previous_transitions = []

    def try_transition(self, letter):
        return self.current_state.try_transition(letter)

    def do_transition(self, letter):
        if self.try_transition(letter):
            next_state = self.current_state.get_transition_state(letter)
            self.previous_transitions.append((self.current_state, letter))
            self.current_state = next_state
        else:
            msg = 'Transition not defined from ' + self.current_state.name + ' with ' + letter
            raise LookupError(msg)

        if self.current_state.isFinalState:
            self.encountered_final_state = True

    def reverse(self):
        (prev_state, letter)  = self.previous_transitions.pop()
        self.current_state = prev_state
        return letter

    def reset(self):
        self.current_state = self.initial_state
        self.encountered_final_state = False
        del self.previous_transitions[:]

    def in_final_state(self):
        return self.current_state.is_final_state

    def _build_states_graph(config_file_path):
        pass
