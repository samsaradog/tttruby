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
    it "has completion message available" do
      @game_view.completion.should == MOVE_MESSAGE
    end
  end
  
  context "draw game" do
    before(:each) do
      modify(@game,@game_string,X_TOKEN,X_DRAW_MOVES)
      modify(@game,@game_string,O_TOKEN,O_DRAW_MOVES)
      @game_view.update(@game)
    end
    
    it "should have the right string" do
      @game_view.representation.should == @game_string
    end
    it "should notify a draw game" do
      @game_view.notification.should == DRAW_GAME_MESSAGE
    end
    it "should show game complete" do
      @game_view.completion.should == GAME_COMPLETED_MESSAGE
    end
  end
  
  context "X winner" do
    before(:each) do
      modify(@game,@game_string,X_TOKEN,["2","4","6"])
      @game_view.update(@game)
    end
    
    it "should have the right string" do
      @game_view.representation.should == @game_string
    end
    it "should show game complete" do
      @game_view.completion.should == GAME_COMPLETED_MESSAGE
    end
    it "should show X as winner" do
      @game_view.notification.should == X_WINS_MESSAGE
    end
  end
  
  context "O winner" do
    before(:each) do
      modify(@game,@game_string,O_TOKEN,["2","5","8"])
      @game_view.update(@game)
    end
    
    it "should have the right string" do
      @game_view.representation.should == @game_string
    end
    it "should show game complete" do
      @game_view.completion.should == GAME_COMPLETED_MESSAGE
    end
    it "should show X as winner" do
      @game_view.notification.should == O_WINS_MESSAGE
    end
  end
end
