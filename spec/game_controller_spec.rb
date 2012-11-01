require_relative "../lib/game_controller"
require_relative "../lib/constants"

class NotTheString
  def initialize(string)
    @string = string
  end
  
  def description
    "the string does match #{@string}"
  end
  
  def ==(actual)
    actual != @string
  end
end

def not_the_string(string)
  NotTheString.new(string)
end

describe "Game Controller" do
  before(:each) do
    @controller = GameController.new()
  end
  
  it "should show an empty game when the user goes first" do
    @controller.stub(:human_first?).and_return(true)
    @controller.stub(:input).and_return("q")
    @controller.should_receive(:output).with(PLAYER_X_FIRST_MESSAGE)
    @controller.should_receive(:output).with(INITIAL_DISPLAY)
    @controller.should_receive(:output).with(MOVE_MESSAGE)
    @controller.should_receive(:output).with(EXIT_MESSAGE)
    @controller.run()
  end
  
  it "should give an error message for bad input" do
    @controller.stub(:human_first?).and_return(true)
    @controller.stub(:input).and_return("z","q")
    @controller.should_receive(:output).exactly(3).times
    @controller.should_receive(:output).with(BAD_INPUT_MESSAGE+"z"+"\n")
    @controller.should_receive(:output).exactly(3).times
    @controller.run()
  end
  
  it "should work when computer goes first" do
    @controller.stub(:human_first?).and_return(false)
    @controller.stub(:input).and_return("q")
    @controller.should_receive(:output).with(PLAYER_O_FIRST_MESSAGE)
    @controller.should_receive(:output).with(not_the_string(INITIAL_DISPLAY))
    @controller.should_receive(:output).with(MOVE_MESSAGE)
    @controller.should_receive(:output).with(EXIT_MESSAGE)
    @controller.run()
  end
  
  it "should work when human goes first and makes a move" do
    @controller.stub(:human_first?).and_return(true)
    @controller.stub(:input).and_return("0","q")
    @controller.should_receive(:output).exactly(3).times
    @controller.should_receive(:output).with(not_the_string(INITIAL_DISPLAY))
    @controller.should_receive(:output).exactly(2).times
    @controller.run()
  end
  
  it "should display an error when human makes a move that's taken" do
    @controller.stub(:human_first?).and_return(true)
    @controller.stub(:input).and_return("0","0","q")
    @controller.should_receive(:output).exactly(5).times
    @controller.should_receive(:output).with("0"+MOVE_TAKEN_MESSAGE)
    @controller.should_receive(:output).exactly(3).times
    @controller.run()
  end
  
  it "should recognize a draw game" do
    @controller.stub(:human_first?).and_return(true)
    @controller.stub(:input).and_return("0","1","5","6","8","q")
    @controller.stub(:generate_move).and_return("2","3","4","7")
    @controller.should_receive(:output).exactly(11).times
    @controller.should_receive(:output).with(DRAW_GAME_MESSAGE)
    @controller.should_receive(:output).once
    @controller.should_receive(:output).with(GAME_COMPLETED_MESSAGE)
    @controller.should_receive(:output).with(EXIT_MESSAGE)
    @controller.run()
    
  end
  
  it "should recognize a human winner" do
    @controller.stub(:human_first?).and_return(true)
    @controller.stub(:input).and_return("0","1","2","q")
    @controller.stub(:generate_move).and_return("3","4")
    @controller.should_receive(:output).exactly(7).times
    @controller.should_receive(:output).with(X_WINS_MESSAGE)
    @controller.should_receive(:output).once
    @controller.should_receive(:output).with(GAME_COMPLETED_MESSAGE)
    @controller.should_receive(:output).with(EXIT_MESSAGE)
    @controller.run()
    
  end
  
  it "should recognize a computer winner" do
    @controller.stub(:human_first?).and_return(false)
    @controller.stub(:generate_move).and_return("0","1","2")
    @controller.stub(:input).and_return("3","4","q")
    @controller.should_receive(:output).exactly(5).times
    @controller.should_receive(:output).with(O_WINS_MESSAGE)
    @controller.should_receive(:output).exactly(3).times
    @controller.run()
    
  end
  
end
