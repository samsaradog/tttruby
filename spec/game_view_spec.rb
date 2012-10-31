require_relative "../lib/game_view"
require_relative "../lib/game"
require_relative "../lib/constants"


describe "GameView" do
  
  def modify(game, string, value, moves)
    moves.each do |position| 
      game.move(position, value)
      string.sub!(Regexp.new(position), value)
    end
    
  end
  
  before(:each) do
    @game        = Game.new
    @game_view   = GameView.new
    @game_string = INITIAL_DISPLAY
  end
  
  context "empty game" do
    
    it "exists" do
      @game_view.should be_an_instance_of GameView
    end
    it "has the initial game representation" do
      @game_view.representation.should == @game_string
    end
    it "has notification message empty" do
      @game_view.notification.should == ""
    end
    it "has error message empty" do
      @game_view.error.should == ""
    end
    it "has completion message available" do
      @game_view.completion.should == "Please make your move"
    end
  end
  
  context "draw game" do
    
    before(:each) do
      modify(@game,@game_string,'X',["0","1","5","6","8"])
      modify(@game,@game_string,'O',["2","3","4","7"])
      @game_view.update(@game)
    end
    
    it "should have the right string" do
      @game_view.representation.should == @game_string
    end
    it "should notify a draw game" do
      @game_view.notification.should == "Draw Game"
    end
    it "should show game complete" do
      @game_view.completion.should == "Would you like to play again?"
    end
  end
  
  context "X winner" do
    
    before(:each) do
      modify(@game,@game_string,'X',["2","4","6"])
      @game_view.update(@game)
    end
    it "should have the right string" do
      @game_view.representation.should == @game_string
    end
    it "should show game complete" do
      @game_view.completion.should == "Would you like to play again?"
    end
    it "should show X as winner" do
      @game_view.notification.should == "X is the Winner!"
    end
  end
  
  context "O winner" do
    
    before(:each) do
      modify(@game,@game_string,'O',["2","5","8"])
      @game_view.update(@game)
    end
    it "should have the right string" do
      @game_view.representation.should == @game_string
    end
    it "should show game complete" do
      @game_view.completion.should == "Would you like to play again?"
    end
    it "should show X as winner" do
      @game_view.notification.should == "O is the Winner!"
    end
  end
end
