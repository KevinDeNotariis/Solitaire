#pragma once
#include "Card.h"
#include <vector>

using namespace std;
class Deck {
public:
    vector<Card> cards;

    Deck();

    void initialize();
    void shuffle(unsigned);
    void print();
};