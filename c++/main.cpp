#include <iostream>
#include <fstream>
#include "Game.h"
#include <map>
#include <chrono>
#include <cmath>

int num_of_games = 1000000;
Deck deck;

// Declare the statistics map
map<int, int> myStat;

int main(){
    Game game(deck);
    
    // Initialize the statistics map
    for (int i = 2; i <= 40; i++) {
        myStat[i] = 0;
    }

    //play games;
    game.play_n_games(num_of_games, myStat);

    // Output files //
    fstream f;
    fstream g;
    f.open("text.txt", ifstream::trunc | ifstream::out);
    for(auto& [key, value] : myStat) {
        f << key <<"\t"<< value << endl;
    }
    f.close(); 
}
