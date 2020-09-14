       IDENTIFICATION DIVISION.
       PROGRAM-ID. SOLITAIRE.
       AUTHOR. KEVIN DE NOTARIIS.
       DATE-WRITTEN. AUGUST 31ST 2020.

       DATA DIVISION.
       LINKAGE SECTION.
           
           01 L-SUIT-TABLE.
               02 L-SUITES PIC A(6) OCCURS 4 TIMES INDEXED BY I.
    
           01 L-DECK.
               02 L-CARDS OCCURS 40 TIMES INDEXED BY J.
                   03 L-VALUE PIC 99.
                   03 L-SUITE PIC A(6).

            01 L-BOQUETS-DECK.
               02 L-BOQUETS-CARDS OCCURS 40 TIMES INDEXED BY K.
                   03 L-BOQUETS-VALUE PIC 99.
                   03 L-BOQUETS-SUIT PIC A(6).        

           01 L-DUMMY-CARD.
               02 L-DUMMY-VALUE PIC 99.
               02 L-DUMMY-SUITE PIC A(6).
       
           01 L-RANDOM_VALUE_INT PIC 99.

           01 L-PRINT_IND    PIC 99 VALUE 1.
           01 L-PLAY_IND     PIC 99 VALUE 1.
           01 L-MOVE_IND     PIC 99 VALUE 1.

           01 L-STAT_BOOL PIC 9 VALUE 0.
               88 L-PRINT_ALL     VALUE 1.
               88 L-PRINT_STAT    VALUE 0.

            01 L-STAT-TABLE.
               02 L-STAT PIC 9(6) OCCURS 40 TIMES INDEXED BY Z.

       PROCEDURE DIVISION USING L-SUIT-TABLE, L-DECK, L-BOQUETS-DECK,
           L-DUMMY-CARD, L-RANDOM_VALUE_INT, L-PRINT_IND, L-PLAY_IND,
           L-MOVE_IND, L-STAT_BOOL, L-STAT-TABLE.
          
           PERFORM SHUFFLE_DECK

           IF L-STAT_BOOL = 1 THEN
               PERFORM PRINT_DECK
           END-IF

           PERFORM PLAY_GAME
 
           ADD 1 TO L-STAT(K)

       EXIT PROGRAM.

       
       *>******************** Shuffle Deck section *********************

       SHUFFLE_DECK.
           PERFORM SHUFFLE_DECK_LOOP VARYING J FROM 1 BY 1
               UNTIL J > 40.
           
       SHUFFLE_DECK_LOOP.
           COMPUTE L-RANDOM_VALUE_INT ROUNDED = (40 * FUNCTION RANDOM)
           IF L-RANDOM_VALUE_INT = 0 THEN
               PERFORM SHUFFLE_DECK_LOOP
           ELSE
               PERFORM SWAP_ELEMENTS
           END-IF.
           
       SWAP_ELEMENTS.

           MOVE L-CARDS(J) TO L-DUMMY-CARD
           MOVE L-CARDS(L-RANDOM_VALUE_INT) TO L-CARDS(J)
           MOVE L-DUMMY-CARD TO L-CARDS(L-RANDOM_VALUE_INT).

       *>***************************************************************

       *>********************* Play Game section ***********************

       PLAY_GAME.
           SET K TO 0
           PERFORM PLAY_GAME_LOOP VARYING J FROM 1 BY 1 UNTIL J > 40.

       PLAY_GAME_LOOP.
           ADD 1 TO K
           MOVE L-CARDS(J) TO L-BOQUETS-CARDS(K)

           *>Print if required
           IF L-STAT_BOOL = 1 THEN
               PERFORM PRINT_BOQUETS
           END-IF

           PERFORM UNTIL K <= 2
               IF L-BOQUETS-SUIT(K) = L-BOQUETS-SUIT(K - 2) 
                OR L-BOQUETS-VALUE(K) = L-BOQUETS-VALUE(K - 2) THEN
                   MOVE L-BOQUETS-CARDS(K - 1) TO 
                    L-BOQUETS-CARDS(K - 2)
                   MOVE L-BOQUETS-CARDS(K) TO L-BOQUETS-CARDS(K - 1)
                   MOVE "00      " TO L-BOQUETS-CARDS(K)

                   *>Print if required
                   IF L-STAT_BOOL = 1 THEN
                       PERFORM PRINT_BOQUETS
                   END-IF

                   SET K DOWN BY 1
                   COMPUTE L-PLAY_IND = K - 1
                   PERFORM PLAY
               ELSE
                   EXIT PERFORM
               END-IF
           END-PERFORM.

       PLAY.
           IF L-PLAY_IND > 2 THEN
               IF L-BOQUETS-SUIT(L-PLAY_IND - 2) = 
                  L-BOQUETS-SUIT(L-PLAY_IND) OR 
                  L-BOQUETS-VALUE(L-PLAY_IND - 2) =
                  L-BOQUETS-VALUE(L-PLAY_IND) THEN
               
                   MOVE L-BOQUETS-CARDS(L-PLAY_IND - 1) TO 
                    L-BOQUETS-CARDS(L-PLAY_IND - 2)
                   PERFORM MOVE_CARDS VARYING L-MOVE_IND FROM L-PLAY_IND
                    BY 1 UNTIL L-MOVE_IND > K
                   MOVE "00      " TO L-BOQUETS-CARDS(K)
                   
                   *>Print if required
                   IF L-STAT_BOOL = 1 THEN
                       PERFORM PRINT_BOQUETS
                   END-IF

                   SET K DOWN BY 1
                   COMPUTE L-PLAY_IND = L-PLAY_IND - 1
                   PERFORM PLAY
               END-IF
           END-IF.

       MOVE_CARDS.
           MOVE L-BOQUETS-CARDS(L-MOVE_IND) TO 
            L-BOQUETS-CARDS(L-MOVE_IND - 1).
       
       *>***************************************************************

       *>********************* Print Deck section **********************
       
       PRINT_DECK.
           DISPLAY " "
           DISPLAY "**********************" WITH NO ADVANCING
           DISPLAY " Deck Configuration "  WITH NO ADVANCING
           DISPLAY "**********************"
           PERFORM PRINT_DECK_LOOP VARYING L-PRINT_IND FROM 1 BY 1
               UNTIL L-PRINT_IND > 40
           DISPLAY " ".

       PRINT_DECK_LOOP.
           DISPLAY "(" L-VALUE(L-PRINT_IND) ", " L-SUIT(L-PRINT_IND) 
           ")" WITH NO ADVANCING.
           
       *>***************************************************************

       *>******************* Print Boquets section *********************
       
       PRINT_BOQUETS.
           DISPLAY " "
      *     DISPLAY "**********************" WITH NO ADVANCING
      *     DISPLAY " Boquets Configuration "  WITH NO ADVANCING
      *     DISPLAY "**********************"
           PERFORM PRINT_BOQUETS_LOOP VARYING L-PRINT_IND FROM 1 BY 1
               UNTIL L-PRINT_IND > 40
           DISPLAY " ".

       PRINT_BOQUETS_LOOP.
           IF L-BOQUETS-CARDS(L-PRINT_IND) NOT EQUAL "00      " THEN
               DISPLAY "(" L-BOQUETS-VALUE(L-PRINT_IND) 
               ", " L-BOQUETS-SUITE(L-PRINT_IND) ")" WITH NO ADVANCING
           END-IF.
           
       *>***************************************************************
