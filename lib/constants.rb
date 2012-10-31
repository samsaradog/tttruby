# magic numbers and strings used in the implementation
# X goes with the max nodes and O with the min nodes

GAME_RANGE_RE     = /[0-8]/
POSITION_ARRAY    = (0..8).to_a
INITIAL_CONDITION = "012345678"

WINNERS_RE = %w( NNN...... ...NNN... ......NNN 
              N..N..N.. .N..N..N. ..N..N..N
              N...N.N.. ..N.N.N.. )
              
WINNER_KEY_RE = /N/

INITIAL_DISPLAY = " 0 | 1 | 2 \n" +
                  "-----------\n" +
                  " 3 | 4 | 5 \n" +
                  "-----------\n" +
                  " 6 | 7 | 8 \n"

X_DRAW_MOVES = ["0","1","5","6","8"]
O_DRAW_MOVES = ["2","3","4","7"]

X_WIN    = "X wins"
O_WIN    = "O wins"
WIN_STUB = " wins"
DRAW     = :draw

