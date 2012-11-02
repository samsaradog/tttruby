require_relative "constants"
require_relative "game"
require_relative "game_view"
require_relative "tree"

class GameController
  
  def initialize()
    @view = GameView.new()
    @game = Game.new()
  end
  
  def run
    # add_response(NEW_GAME_TOKEN)
    initialize_game()
    
    while(1)
      show_game()
      break unless(add_response(input))
    end
  end
  
  def add_response(response)
    
    unless validate_response(response, 
                             Regexp.union(NEW_GAME_RE,QUIT_GAME_RE),
                             MOVE_RANGE_RE,
                             @game.completed)
      output(BAD_INPUT_MESSAGE + response + "\n")
      return true
    end
    
    return_value = true
    
    case response
    when NEW_GAME_RE
      initialize_game()
      
    when QUIT_GAME_RE
      output(EXIT_MESSAGE)
      return_value = false
      
    when MOVE_RANGE_RE
      begin
        @game.move(response,PLAYER_X_MOVE)
        @view.update(@game)
      rescue
        output(response+MOVE_TAKEN_MESSAGE)
      else
        unless @game.completed 
          @game.move(generate_move,PLAYER_O_MOVE)
          @view.update(@game)
        end
      end
      
    end #case
    
    return_value
  end
  
  def initialize_game
    @game = Game.new()
    @view = GameView.new()
    
    if ( human_first? )
      output(PLAYER_X_FIRST_MESSAGE)
    else
      output(PLAYER_O_FIRST_MESSAGE)
      @game.move(generate_move,PLAYER_O_MOVE)
    end
  end
  
  def validate_response(response, yes_no_re, move_re, game_complete)
    test_re = (game_complete) ? yes_no_re : Regexp.union(yes_no_re, move_re)
    test_re =~ response and (response.length == 1)
  end
  
  def show_game
    @view.update(@game)
    output(@view.notification)
    output(@view.representation)
    output(@view.completion)
  end
  
  def generate_move
    MaxNode.new(@game).move
  end
  
  def input
    gets.chomp
  end
  
  def output(message)
    puts message
  end
  
  def human_first?
    ( 0 == rand(2) )
  end
end
