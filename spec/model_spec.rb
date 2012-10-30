require_relative "../lib/model"

describe "Model" do
  
  before(:each) do
    @model = Model.new
  end
  
  context "initial game" do
    
    describe "#new" do
      it "exists" do
        @model.should be_an_instance_of Model
      end
      it "has error state none" do
        @model.error.should == :none
      end
      it "has completed state false" do
        @model.completed.should == false
      end
      it "has notification state :empty" do
        @model.notification.should == :empty
      end
      it "has initial condition" do
        @model.condition.should == "012345678"
      end
    end
  end
  
  context "draw game" do
    before(:each) do
      ["0","1","5","6","8"].each { |position| @model.move(position,'X')  }
      ["2","3","4","7"].each     { |position| @model.move(position,'O')  }
    end
    
    it "has error state none" do
      @model.error.should == :none
    end
    it "has completed state true" do
      @model.completed.should == true
    end
    it "has notification state :draw" do
      @model.notification.should == :draw
    end
    it "throws an exception when adding another move" do
      lambda { @model.move("0",'X') }.should raise_error(RuntimeError)
    end
  end
  
  context "X winner" do
    before(:each) do
      ["0","1","2"].each { | position | @model.move(position, 'X') }
    end
    it "should show X as the winner" do
      @model.notification.should == "X wins"
    end
    it "should show the game complete" do
      @model.completed.should == true
    end
    it "has error state none" do
      @model.error.should == :none
    end
    it "has the right condition" do
      @model.condition.should == "XXX345678"
    end
  end
end
