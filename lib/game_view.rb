require_relative "game"
require_relative "constants"

class GameView
  attr_reader :representation, :notification, :error, :completion
  
  def initialize
    @representation = INITIAL_DISPLAY.dup

    @notification = ""
    @error        = ""
    @completion   = "Please make your move"
  end
   
  def update(game)
    POSITION_ARRAY.each do | position |
       value = game.condition[position]
       @representation.sub!(Regexp.new(position.to_s), value) unless value.match(GAME_RANGE_RE)
     end
     
     @completion   = "Would you like to play again?" if game.completed
     @notification = update_notification(game)
  end
  
  def update_notification(game)
    case game.notification
    when :empty
      ""
    when :draw
      "Draw Game"
    when "X wins"
      "X is the Winner!"
    when "O wins"
      "O is the Winner!"
    end
  end
end