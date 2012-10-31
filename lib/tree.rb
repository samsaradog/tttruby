require_relative "game"

class TreeNode
  attr_reader :value, :move
  
  # def minimax
  # end
  # 
  def get_value(state)
    case state
    when X_WIN
      -1
    when O_WIN
      1
    when DRAW
      0
    else
      raise RuntimeError
    end
  end
  
  def get_moves(game)
    game.condition.split('').grep(GAME_RANGE_RE).shuffle
  end
end

class MinNode < TreeNode
  
  def initialize(game, min=-1, max=1)
    (game.completed) ? @value = get_value(game.notification) : minimax(game, min,max)
  end
  
  def minimax(game, min, max)
    available_moves = get_moves(game)
    @value = max
    
    available_moves.each do | next_move |
      
      new_game = game.dup
      new_game.move(next_move,'X')
      node = MaxNode.new(new_game,min,@value)
      
      if ( node.value < @value)
        @value = node.value
        @move  = next_move
      end
      
      if ( @value <= min )
        @value = min
        break
      end
      
    end #each loop
    
  end
  
end

class MaxNode < TreeNode

  def initialize(game, min=-1, max=1)
    (game.completed) ? @value = get_value(game.notification) : minimax(game, min,max)
  end
  
  def minimax(game, min, max)
    available_moves = get_moves(game)
    @value = min
    
    available_moves.each do | next_move |
      
      new_game = game.dup
      new_game.move(next_move,'O')
      node = MinNode.new(new_game,@value,max)
      
      if ( node.value > @value)
        @value = node.value
        @move  = next_move
      end
      
      if ( @value >= max )
        @value = max
        break
      end
      
    end #each loop
    
  end
  
end