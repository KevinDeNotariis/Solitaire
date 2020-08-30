#pragma once
#include "Deck.h"
#include <vector>
#include <string>
#include <utility>
#include <iostream>
#include <map>
#include <chrono>

using namespace std;
class Game{
public:
	Deck deck;
	vector<Card> boquets;

	Game(Deck);

	void play();
	void play_n_games(int, map<int,int>&);
	bool isMatch();
	void play(int);
	bool isMatch(int);
	void print();
};

