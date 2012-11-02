# magic numbers and strings used in the implementation
# X goes with the max nodes and O with the min nodes

GAME_RANGE_RE     = /[0-8]/
POSITION_ARRAY    = (0..8).to_a
INITIAL_CONDITION = "012345678"

WINNERS_RE = %w( NNN...... ...NNN... ......NNN 
              N..N..N.. .N..N..N. ..N..N..N
              N...N...N ..N.N.N.. )
              
WINNER_KEY_RE = /N/

INITIAL_DISPLAY = " 0 | 1 | 2 \n" +
                  "-----------\n" +
                  " 3 | 4 | 5 \n" +
                  "-----------\n" +
                  " 6 | 7 | 8 \n"

X_DRAW_MOVES = ["0","1","5","6","8"]
O_DRAW_MOVES = ["2","3","4","7"]

X_TOKEN = "X"
O_TOKEN = "O"

NEW_GAME_TOKEN = "Y"
QUIT_TOKEN     = "q"

BAD_INPUT_1 = "z"
BAD_INPUT_2 = "94xd324jkl;"
BAD_INPUT_3 = ""

X_WIN    = "X wins"
O_WIN    = "O wins"
WIN_STUB = " wins"
DRAW     = :draw

O_WILL_WIN = "O will win"

MOVE_MESSAGE = "Please choose 0-8 to move,\n" +
               "Y for a new game or Q to quit.\n"
               
NEW_GAME_RE   = /y/i
QUIT_GAME_RE  = /[qxn]/i
MOVE_RANGE_RE = /[0-8]/

PLAYER_X_FIRST_MESSAGE = "Human moves first\n"
PLAYER_O_FIRST_MESSAGE = "Computer moves first\n"

PLAYER_X_MOVE = "X"
PLAYER_O_MOVE = "O"

TEASE_MESSAGE = "Computer is going to win\n"

MOVE_TAKEN_MESSAGE = " not available. Please choose another\n"

BAD_INPUT_MESSAGE = "Sorry, I don't understand "

DRAW_GAME_MESSAGE = "Draw Game"
X_WINS_MESSAGE    = "X is the Winner!"
O_WINS_MESSAGE    = "O is the Winner!"

GAME_COMPLETED_MESSAGE = "Would you like to play again? (Y/N)"

EXIT_MESSAGE = "Thank you for playing!\n"

