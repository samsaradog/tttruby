require_relative "../lib/tree"
require_relative "../lib/game"
require_relative "../lib/constants"


describe "Tree" do
  before(:each) do
    @game = Game.new
  end
  
  context "draw game" do
    before(:each) do
      X_DRAW_MOVES.each { | pos | @game.move(pos,'X') }
      O_DRAW_MOVES.each { | pos | @game.move(pos,'O') }
    end
    
    it "min should have value 0" do
      node = MinNode.new(@game)
      node.value.should == 0
    end
    
    it "max should have value 0" do
      node = MaxNode.new(@game)
      node.value.should == 0
    end
  end
  
  context "O winning max node" do
    before(:each) do
      ("0".."2").to_a.each { | pos | @game.move(pos,'X')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value -1" do
      @node.value.should == -1
    end
    
    it "should have an empty move" do
      @node.move.should be_false
    end
  end
  
  context "X winning min node" do
    before(:each) do
      ("0".."2").to_a.each { | pos | @game.move(pos,'O')}
      @node = MinNode.new(@game)
    end
    
    it "should have the value 1" do
      @node.value.should == 1
    end
    
    it "should have an empty move" do
      @node.move.should be_false
    end
  end
  
  context "min win depth 1" do
    #  X | O | X
    # ----------
    #  X | O | O
    # ----------
    #    | X | O
    
    before(:each) do
      ["0","2","3","7"].each { | pos | @game.move(pos,'X')}
      ["1","4","5","8"].each { | pos | @game.move(pos,'O')}
      @node = MinNode.new(@game)
    end
    
    it "should have the value -1" do
      @node.value.should == -1
    end
    
    it "should have the move 6" do
      @node.move.should == "6"
    end
     
  end
  
  context "max win depth 1" do
    #  O | X | O
    # ----------
    #  O | X | X
    # ----------
    #    | O | X
    
    before(:each) do
      ["0","2","3","7"].each { | pos | @game.move(pos,'O')}
      ["1","4","5","8"].each { | pos | @game.move(pos,'X')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 1" do
      @node.value.should == 1
    end
    
    it "should have the move 6" do
      @node.move.should == "6"
    end
     
  end
  
  context "min lose depth 2" do
    #    | X |  
    # ----------
    #  O | O | X
    # ----------
    # O | X | O
    
    before(:each) do
      ["3","4","6","8"].each { | pos | @game.move(pos,'O')}
      ["1","5","7"].each { | pos | @game.move(pos,'X')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 1" do
      @node.value.should == 1
    end
    
    it "should have the move 0 or 2" do
      result = (@node.move == "0" or @node.move == "2")
      result.should be_true
    end
    
  end
  
  context "max lose depth 2" do
    #    | O |  
    # ----------
    #  X | X | O
    # ----------
    # X | O | X
    
    before(:each) do
      ["3","4","6","8"].each { | pos | @game.move(pos,'X')}
      ["1","5","7"].each { | pos | @game.move(pos,'O')}
      @node = MinNode.new(@game)
    end
    
    it "should have the value -1" do
      @node.value.should == -1
    end
    
    it "should have the move 0 or 2" do
      result = (@node.move == "0" or @node.move == "2")
      result.should be_true
    end
    
  end
  
  context "max draw depth 5" do
    #    |   |  
    # ----------
    #  X | X |  
    # ----------
    # O |   |  
    
    before(:each) do
      ["3","4"].each { | pos | @game.move(pos,'X')}
      ["6"].each { | pos | @game.move(pos,'O')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 0" do
      @node.value.should == 0
    end
    
    it "should have the move 5" do
      @node.move.should == "5"
    end
    
  end
  
  context "max win depth 5" do
    #    | X |  
    # ----------
    #    | O | O
    # ----------
    #   |   | X
    
    before(:each) do
      ["1","8"].each { | pos | @game.move(pos,'X')}
      ["4","5"].each { | pos | @game.move(pos,'O')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 1" do
      @node.value.should == 1
    end
    
    # The algorighm is about winning, but not winning quickly, so the 
    # computer could pick one of several moves that will lead to an
    # eventual win
    
  end
  
  context "max draw depth 6" do
    #  O | X |  
    # ----------
    #    | X |  
    # ----------
    #   |   |  
    
    before(:each) do
      ["1","4"].each { | pos | @game.move(pos,'X')}
      ["0"].each { | pos | @game.move(pos,'O')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 0" do
      @node.value.should == 0
    end
    
    it "should have the move 7" do
      @node.move.should == "7"
    end
    
  end
  
  context "max draw depth 7" do
    #    | O |  
    # ----------
    #    | X |  
    # ----------
    #   |   |  
    
    before(:each) do
      ["4"].each { | pos | @game.move(pos,'X')}
      ["1"].each { | pos | @game.move(pos,'O')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 0" do
      @node.value.should == 0
    end
    
  end
  
  context "max win depth 7" do
    #    | X |  
    # ----------
    #    | O |  
    # ----------
    #   |   |  
    
    before(:each) do
      ["4"].each { | pos | @game.move(pos,'O')}
      ["1"].each { | pos | @game.move(pos,'X')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 1" do
      @node.value.should == 1
    end
    
  end
  
  context "max draw depth 8" do
    #    |   |  
    # ----------
    #    | X |  
    # ----------
    #   |   |  
    
    before(:each) do
      ["4"].each { | pos | @game.move(pos,'X')}
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 0" do
      @node.value.should == 0
    end
    
  end
  
  context "max draw depth 9" do
    #    |   |  
    # ----------
    #    |   |  
    # ----------
    #   |   |  
    
    before(:each) do
      @node = MaxNode.new(@game)
    end
    
    it "should have the value 0" do
      @node.value.should == 0
    end
    
  end
end
