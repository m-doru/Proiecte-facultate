import type

class State:
    def __init__(self, name, type=None, is_final_state=False):
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

    def make_transition(self, letter):
        if self.try_transition(letter):
            next_state = self.current_state.get_transition_state(letter)
            self.previous_transitions.append((self.current_state, letter))
            self.current_state = next_state
        else:
            msg = 'Transition not defined from ' + self.current_state.name + ' with ' + letter
            raise LookupError(msg)

        if self.current_state.is_final_state:
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

    def _build_states_graph(self, config_file_path):
        with open(config_file_path, 'r') as configFile:
            states = {}
            processing_transitions = True
            for line in configFile:
                line = line.strip('\n')
                transition_info = line.split(' ')

                if len(transition_info) == 1:
                    processing_transitions = False
                    continue

                if processing_transitions:
                    # transition_info[0] - source state name
                    # transition_info[1] - transition letter
                    # transition_info[2] - detination state name

                    if transition_info[0] in states:
                        source_state = states[transition_info[0]]
                    else:
                        source_state = State(transition_info[0])
                        states[transition_info[0]] = source_state

                    if transition_info[2] in states:
                        destination_state = states[transition_info[2]]
                    else:
                        destination_state = State(transition_info[2])
                        states[transition_info[2]] = destination_state

                    source_state.add_transition(transition_info[1], destination_state)
                else:
                    # transition_info structure
                    # transition_info[0] - state name
                    # transition_info[1] - is final state
                    # trnasition_info[2] - state type in case it is final state
                    state = states[transition_info[0]]
                    if transition_info[1] == 'final':
                        state.is_final_state = True
                        state.type = type.Type[transition_info[2]]
                    elif transition_info[1] == 'start':
                        start_state = states[transition_info[0]]

        return start_state
