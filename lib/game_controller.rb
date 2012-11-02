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
    add_response("Y")
    
    while(1)
      break unless(add_response(input))
    end
    
  end
  
  def add_response(response)
    
    return_value = true
    
    case response
    when /y/i
      @game = Game.new()
      @view = GameView.new()
      
      if ( human_first? )
        output(PLAYER_X_FIRST_MESSAGE)
      else
        output(PLAYER_O_FIRST_MESSAGE)
        @game.move(generate_move,PLAYER_O_MOVE)
      end
      
    when /[qxn]/i
      output(EXIT_MESSAGE)
      return_value = false
      
    when /[0-8]/
      begin
        @game.move(response,PLAYER_X_MOVE)
        @view.update(@game)
      rescue
        output(response+MOVE_TAKEN_MESSAGE)
      else
        if ( false == @game.completed )
          @game.move(generate_move,PLAYER_O_MOVE)
          @view.update(@game)
          output(@view.notification) if @game.completed
        else
          output(@view.notification)
        end
      end
    else
      output(BAD_INPUT_MESSAGE + response + "\n")
      
    end
    
    if (return_value)
      @view.update(@game)
      output(@view.representation)
      output(@view.completion)
    end
    
    return_value
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
