import numpy as np


class Card:
    def __init__(self, _value, _suit):
        self.value = _value
        self.suit = _suit

    def __repr__(self):
        return "(" + str(self.value) + ", " + self.suit + ")"


class Deck:
    cards = []

    def __init__(self):
        for suit in ["coins", "cups", "swords", "clubs"]:
            for i in range(1, 11):
                self.cards.append(Card(i, suit))


class Game:
    deck = Deck()
    boquets = []
    stat = {}

    def __init__(self):
        np.random.shuffle(self.deck.cards)

    def play_n_games(self, n):
        self.stat = {_stat: 0 for _stat in range(2, 41)}
        for i in range(n):
            self.play()
            self.stat[len(self.boquets)] += 1
            self.boquets.clear()
            self.deck = Deck()
            np.random.shuffle(self.deck.cards)

    def play(self):
        for i in range(len(self.deck.cards)):
            self.boquets.append(self.deck.cards.pop())
            # print(self.boquets)
            while len(self.boquets) > 2:
                if self.isMatch():
                    self.boquets[len(self.boquets) - 3] = self.boquets[len(self.boquets) - 2]
                    self.boquets.pop(len(self.boquets) - 2)
                    # print(self.boquets)
                    self.play_n(len(self.boquets) - 2)
                else:
                    break

    def play_n(self, n):
        if self.isMatch_n(n):
            self.boquets[n-2] = self.boquets[n-1]
            self.boquets.pop(n-1)
            # print(self.boquets)
            self.play_n(n-1)

    def isMatch(self):
        if len(self.boquets) > 2:
            if (self.boquets[len(self.boquets)-1].value == self.boquets[len(self.boquets)-3].value) or (self.boquets[len(self.boquets)-1].suit == self.boquets[len(self.boquets)-3].suit):
                return True
            else:
                return False
        else:
            return False

    def isMatch_n(self, n):
        if len(self.boquets) > 2:
            return True if (self.boquets[n].value == self.boquets[n-2].value) or (self.boquets[n].suit == self.boquets[n-2].suit) else False
        else:
            return False


game = Game()
game.play_n_games(100000)
f = open("text.txt", "a")
for key, value in game.stat.items():
    f.write(str(key) + "\t" + str(value) + "\n")
f.close()
