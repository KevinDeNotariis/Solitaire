# Solitaire
Solitaire Game Using the italian 40 cards deck

* This solitaire is played using the italian 40 cards deck. 
* The suites are:
  1) Clubs;
  2) Swords;
  3) Cups;
  4) Coins.
* Rules of the game:
  1) Start with the deck shuffled in a random order.
  2) Put the first card at the top of the deck on the table, face up.
  3) Put the again the top card of the deck near the other card (on the right for example), face up.
  4) Take the top card of the deck and put it on the right of the last card, face up again.
  5) Now, check the last card and the first you put. If they match in suite or in value, then take the
     the second card (the one in-between) and put it on top of the first card.
     
     > --- Example ---
     >
     > You follow the steps 1 through 5 and you get:
     >
     > 1 --> shuffle deck.
     >
     > 2 --> table configuration: (3, swords).
     >
     > 3 --> table configuration: (3, swords) (7, coins).
     >
     > 4 --> table configuration: (3, swords), (7, coins) (3, clubs).
     >
     > 5 --> since the third card and the first card share the same value, you take
     >       the second card and put it on top of the first, obtaining:
     >
     >       table configuration: (7, coins) (3, clubs).
            
  6) Repeat from 2), and always check the last card (or the card you put on top of another one)
     with the one two steps back.

* Note, consider the following table configuration:

  > table configuration: (3 cups) (7, coins) (4 swords) (5, swords) (7, cups) (8, swords).
  
  Since the last card you put on the table is a (8, swords) and there is the (5, swords),
  you put the (7, cups) on top of the (5, swords) obtaining:
  
  > table configuration: (3, swords) (7, coins) (4, swords) (7, cups) (8, swords).
  
  Now, before checking the (8, swords) with the (4 swords), you need to check the card that you
  have just put on top of another one, namely you have to check the (7, cups) with the (7, coins)
  and since they share the value, you have to put the (4, swords) on top of the (7, coins), obtaining:
  
  > table configuration: (3, swords), (4, swords), (7, cups) (8, swords).
  
  Now, you should check the (4, swords), but there is no card to check it with, so you rewind back, and check
  (7, cups) with (3 swords) and do nothing since they do not share neither the suite nor the value. After that,
  you check the (8, swords) with the (4 swords) and since they share the suite, you put the card in-between, namely
  the (7, cups) on top of the (4, swords), obtaining:
  
  > table configuration: (3, swords) (7, cups) (8, swords).
  
  Again, you check the (8, swords) against the (3, swords) and then put the (7, cups) on top of the (3, swords):
  
  > table configuration: (3, swords) (8, swords).
  
  And now you can now show face-up another face on the right of the (8, swords) and continue the game.
  
