require_relative "constants"

class Game
  attr_reader :notification, :completed, :error, :condition
  
  def initialize
    @notification = :empty
    @completed    = false
    @error        = :none
    @condition    = INITIAL_CONDITION
    
    @winners      = WINNERS_RE
    
  end
  
  def ==(other)
    @notification == other.notification and
    @completed    == other.completed   and
    @condition    == other.condition
  end
  
  def valid_move?(position)
    position =~ GAME_RANGE_RE
  end
  
  def move(position, value)
    raise RangeError   unless valid_move?(position)
    raise RuntimeError unless @condition.include?(position)
    
    @condition = @condition.sub(position, value) 
    winner_check(value)
    state_check
  end
  
  def state_check
    unless @completed
      @completed = !valid_move?(@condition)
      @notification = :draw if @completed
    end
  end
  
  def winner_check(value)
    @winners.each do | pattern |
      if @condition.match(pattern.gsub(WINNER_KEY_RE, value))
        @completed = true
        @notification = value + WIN_STUB
        break
      end
    end 
  end
  
end