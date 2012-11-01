require_relative "game"
require_relative "constants"

class GameView
  attr_reader :representation, :notification, :error, :completion
  
  def initialize
    @representation = INITIAL_DISPLAY.dup

    @notification = ""
    @error        = ""
    @completion   = MOVE_MESSAGE
  end
   
  def update(game)
    POSITION_ARRAY.each do | position |
       value = game.condition[position]
       @representation.sub!(Regexp.new(position.to_s), value) unless value.match(GAME_RANGE_RE)
     end
     
     @completion   = GAME_COMPLETED_MESSAGE if game.completed
     @notification = update_notification(game)
  end
  
  def update_notification(game)
    case game.notification
    when :empty
      ""
    when DRAW
      DRAW_GAME_MESSAGE
    when X_WIN
      X_WINS_MESSAGE
    when O_WIN
      O_WINS_MESSAGE
    end
  end
end