class Model
  attr_reader :notification, :completed, :error, :condition
  
  def initialize
    @notification = :empty
    @completed    = false
    @error        = :none
    @condition    = "012345678"
    
    @winners      = %w( NNN...... ...NNN... ......NNN 
                        N..N..N.. .N..N..N. ..N..N..N
                        N...N.N.. ..N.N.N.. )
  end
  
  def move(position, value)
    raise RuntimeError if !Regexp.new(position).match(@condition)
    
    @condition.sub!(position, value) 
    winner_check(value)
    state_check
  end
  
  def state_check
    if (!@completed)
      @completed = (@condition !~ /[0..8]/)
      @notification = :draw if @completed
    end
  end
  
  def winner_check(value)
    value_winners = @winners.each { | pattern | pattern.gsub!(/N/, value) }
    value_winners.each do | pattern |
      if Regexp.new(pattern).match(@condition)
        @completed = true
        @notification = "#{value} wins"
      end
    end
  end
end