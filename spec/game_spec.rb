require_relative "../lib/game"

describe "Game" do
  before(:each) do
    @game = Game.new
  end
  
  context "initial game" do
    it "exists" do
      @game.should be_an_instance_of Game
    end
    it "has completed state false" do
      @game.completed.should == false
    end
    it "has notification state :empty" do
      @game.notification.should == :empty
    end
    it "has initial condition" do
      @game.condition.should == "012345678"
    end
    it "throws a range error when adding a bad move" do
      lambda { @game.move("X",X_TOKEN) }.should raise_error(RangeError)
    end
  end
  
  context "draw game" do
    before(:each) do
      X_DRAW_MOVES.each { |position| @game.move(position,X_TOKEN)  }
      O_DRAW_MOVES.each { |position| @game.move(position,O_TOKEN)  }
    end
    
    it "has completed state true" do
      @game.completed.should == true
    end
    it "has notification state :draw" do
      @game.notification.should == :draw
    end
    it "throws a runtime error when adding another move" do
      lambda { @game.move("0",X_TOKEN) }.should raise_error(RuntimeError)
    end
  end
  
  context "X winner" do
    before(:each) do
      ("0".."2").to_a.each { | position | @game.move(position, X_TOKEN) }
    end
    
    it "should show X as the winner" do
      @game.notification.should == X_WIN
    end
    it "should show the game complete" do
      @game.completed.should == true
    end
    it "has the right condition" do
      @game.condition.should == "XXX345678"
    end
  end
  
  context "O winner" do
    before(:each) do
      ("6".."8").to_a.each { | position | @game.move(position, O_TOKEN) }
    end
    
    it "should show X as the winner" do
      @game.notification.should == O_WIN
    end
    it "should show the game complete" do
      @game.completed.should == true
    end
    it "has the right condition" do
      @game.condition.should == "012345OOO"
    end
  end
  
  context "duplicating game" do
    it "should show duplicated games equal" do
      new_game = @game.dup
      @game.should == new_game
      @game.should_not equal new_game
    end
    it "should show modified game not equal" do
      new_game = @game.dup
      ("0".."2").to_a.each { | position | new_game.move(position,X_TOKEN) }
      @game.should_not == new_game
      @game.completed.should_not == new_game.completed
      @game.condition.should_not  == new_game.condition
    end
  end
end
