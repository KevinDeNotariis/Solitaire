       IDENTIFICATION DIVISION.
       PROGRAM-ID. SOLITAIRE_PLAY_N_GAMES.
       AUTHOR. KEVIN DE NOTARIIS.
       DATE-WRITTEN. AUGUST 2ND 2020.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
           01 WS-SUIT-TABLE.
               02 WS-SUITS PIC A(6) OCCURS 4 TIMES INDEXED BY I.
    
           01 WS-DECK.
               02 WS-CARDS OCCURS 40 TIMES INDEXED BY J.
                   03 WS-VALUE PIC 99.
                   03 WS-SUIT PIC A(6).

            01 WS-BOQUETS-DECK.
               02 WS-BOQUETS-CARDS OCCURS 40 TIMES INDEXED BY K.
                   03 WS-BOQUETS-VALUE PIC 99.
                   03 WS-BOQUETS-SUIT PIC A(6).        

           01 VALUE_INDEX  PIC 99 VALUE 1.

           01 WS-DUMMY-CARD.
               02 WS-DUMMY-VALUE PIC 99.
               02 WS-DUMMY-SUIT PIC A(6).
       
           01 WS-RANDOM_VALUE_INT PIC 99.

           01 WS-PRINT_IND    PIC 99 VALUE 1.
           01 WS-PLAY_IND     PIC 99 VALUE 1.
           01 WS-MOVE_IND     PIC 99 VALUE 1.

           01 SEED PIC 9(8) VALUE 11.

           01 WS-NUM_OF_GAMES      PIC 9(6) VALUE 1.
           01 WS-PLAY_N_GAMES_IND  PIC 9(6) VALUE 1.

           01 WS-STAT_BOOL PIC 9 VALUE 0.
               88 WS-PRINT_ALL     VALUE 1.
               88 WS-PRINT_STAT    VALUE 0.

           01 WS-STAT-TABLE.
               02 WS-STAT PIC 9(6) VALUE 0 OCCURS 40 TIMES INDEXED BY Z.

       PROCEDURE DIVISION.

           *> Init random numbers.
           COMPUTE WS-RANDOM_VALUE_INT ROUNDED = FUNCTION RANDOM(SEED)

           PERFORM INIT_SUIT_TABLE

           PERFORM INIT_DECK

           DISPLAY "How many games would you like to play? " WITH 
            NO ADVANCING

           ACCEPT WS-NUM_OF_GAMES

           DISPLAY "Would you like to display all the games (type 1), " 
            "or just the statistics (type 0)?"
       
           ACCEPT WS-STAT_BOOL

           PERFORM PLAY_N_GAMES

           IF WS-STAT_BOOL = 0 THEN
               PERFORM PRINT_STAT
           END-IF
           
       STOP RUN.

       *>********************* Initialize section **********************

       INIT_SUIT_TABLE.                                       
          MOVE "CLUBS"     TO WS-SUITS(1)                                     
          MOVE "SWORDS"    TO WS-SUITS(2)                                     
          MOVE "COINS"     TO WS-SUITS(3)                                     
          MOVE "CUPS"      TO WS-SUITS(4).                                        
                                           
       INIT_DECK.                                      
           PERFORM INIT_DECK_SUIT_LOOP VARYING I FROM 1 BY 1                                      
               UNTIL I > 4.                                        
                                           
       INIT_DECK_SUIT_LOOP.                                       
           PERFORM INIT_DECK_VALUE_LOOP VARYING J FROM 1 BY 1                                      
               UNTIL J > 10.                                       
                                               
       INIT_DECK_VALUE_LOOP.                                       
           MOVE WS-SUITS(I) TO WS-SUIT(VALUE_INDEX)                                      
           MOVE J TO WS-VALUE(VALUE_INDEX)                                     
           ADD 1 TO VALUE_INDEX.                                       

       *>***************************************************************
       
       *>******************** Play n games section *********************

       PLAY_N_GAMES.
           PERFORM PLAY_N_GAMES_LOOP VARYING WS-PLAY_N_GAMES_IND 
           FROM 1 BY 1 UNTIL WS-PLAY_N_GAMES_IND > WS-NUM_OF_GAMES.

       PLAY_N_GAMES_LOOP.
           IF WS-STAT_BOOL = 1 THEN
               DISPLAY " "
               DISPLAY "----------------------------------------------"
               DISPLAY "Playing game number: " WS-PLAY_N_GAMES_IND
               DISPLAY " "
           END-IF
           CALL 'SOLITAIRE' USING BY CONTENT WS-SUIT-TABLE, BY CONTENT
            WS-DECK, BY CONTENT WS-BOQUETS-DECK, 
            BY CONTENT WS-DUMMY-CARD, BY CONTENT WS-RANDOM_VALUE_INT,
            BY CONTENT WS-PRINT_IND, BY CONTENT WS-PLAY_IND, BY CONTENT
            WS-MOVE_IND, WS-STAT_BOOL, BY REFERENCE WS-STAT-TABLE.

       *>***************************************************************
       
       *>********************* Print stat section **********************
       
       PRINT_STAT.
           PERFORM PRINT_STAT_LOOP VARYING Z FROM 1 BY 1 UNTIL Z > 40.

       PRINT_STAT_LOOP.
           DISPLAY Z ": " WS-STAT(Z).


       *>***************************************************************
