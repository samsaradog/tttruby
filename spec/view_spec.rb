require_relative "../lib/view"
require_relative "../lib/model"

describe "View" do
  
  before(:each) do
    @view = View.new
    @game_string  = " 0 | 1 | 2 \n" +
                    "-----------\n" +
                    " 3 | 4 | 5 \n" +
                    "-----------\n" +
                    " 6 | 7 | 8 \n"
  end
  
  context "empty game" do
    
    describe "#new" do
      it "exists" do
        @view.should be_an_instance_of View
      end
      it "has the initial game representation" do
        @view.representation.should == @game_string
      end
      it "has notification message empty" do
        @view.notification.should == ""
      end
      it "has error message empty" do
        @view.error.should == ""
      end
      it "has completion message available" do
        @view.completion.should == "Please make your move"
      end
    end
  end
  
  context "draw game" do
    def modify(model, string, value, moves)
      moves.each do |position| 
        model.move(position, value)
        string.sub!(Regexp.new(position), value)
      end
      
    end
    
    before(:each) do
      @model = Model.new
      
      modify(@model,@game_string,'X',["0","1","5","6","8"])
      modify(@model,@game_string,'O',["2","3","4","7"])
      
      @view.update(@model)
    end
    
    it "should have the right string" do
      @view.representation.should == @game_string
    end
    
  end
end
