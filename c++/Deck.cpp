#include "Deck.h"
#include <vector>
#include <cstdlib>
#include <ctime>
#include <algorithm>
#include <iostream>
#include <random>

using namespace std;

Deck::Deck(){
    cards.resize(0);
    initialize();
}

void Deck::initialize(){
    vector<string> suits = {"swords", "coins", "cups", "clubs"};

    for(string s : suits){
        for(int i=1; i<=10; i++){
            Card card(i, s);
            cards.push_back(card);
        }
    }
}

void Deck::shuffle(unsigned seed){
    std::shuffle(cards.begin(), cards.end(), default_random_engine(seed));
}

void Deck::print() {
    cout << "[";
    for (int i = 0; i < cards.size(); i++) {
        if (i != cards.size() - 1)
            cout << "(" << cards.at(i).v << ", " << cards.at(i).s << "),";
        else
            cout << "(" << cards.at(i).v << ", " << cards.at(i).s << ")]" << endl<<endl;
    }
}