#include "Game.h"

Game::Game(Deck _deck): deck(_deck){}

void Game::play() {
	for (int i = deck.cards.size() - 1; i >= 0; i--) {
		boquets.push_back(deck.cards.back());
		deck.cards.pop_back();
		// print();
		while (boquets.size() > 2) {
			if (isMatch()) {
				boquets.at(boquets.size() - 3) = boquets.at(boquets.size()-2);
				boquets.erase(boquets.end() - 2);
				// print();
				play(boquets.size()-2);
			}
			else {
				break;
			}
		}
	}
}

void Game::play_n_games(int n, map<int, int>& stat) {

	Deck _deck = deck;

	// Progression of auto playing
	vector<pair<bool, int>> checks;
	for (int i = 1; i < 10; i++) {
		checks.push_back(pair(true, i * 10));
	}

	for (int i = 0; i < n; i++) {
		unsigned seed = chrono::system_clock::now().time_since_epoch().count();
		deck = _deck;
		deck.shuffle(seed);
		boquets.resize(0);
		play();
		stat[boquets.size()]++;

		for (int j = 0; j < checks.size(); j++) {
			if (checks.at(j).first && floor((((double)i / (double)n)) * 100) == checks.at(j).second) {
				cout << checks.at(j).second << "%" << endl;
				checks.at(j).first = false;
			}
		}
	}

}

void Game::play(int n) {
	if (isMatch(n)) {
		boquets.at(n - 2) = boquets.at(n - 1);
		boquets.erase(boquets.begin() + n);
		// print();
		play(n - 2);
	}
}

bool Game::isMatch() {
	if (boquets.size() > 2) {
		return (boquets.back().s == boquets.at(boquets.size() - 3).s || boquets.back().v == boquets.at(boquets.size() - 3).v) ? true : false;
	}
	return false;
}

bool Game::isMatch(int n) {
	if (n >= 2) {
		return (boquets.at(n).s == boquets.at(n - 2).s || boquets.at(n).v == boquets.at(n - 2).v) ? true : false;
	}
	return false;
}

void Game::print() {
	cout << "--------------------------------------" << endl << endl;
	for (Card card : boquets) {
		cout << "(" << card.v << ", " << card.s << ") ";
	}
	cout << endl;
}