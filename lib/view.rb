require_relative 'model'

class View
  attr_reader :representation, :notification, :error, :completion
  
  def initialize
    @representation = " 0 | 1 | 2 \n" +
                      "-----------\n" +
                      " 3 | 4 | 5 \n" +
                      "-----------\n" +
                      " 6 | 7 | 8 \n"
                      
    @notification = ""
    @error        = ""
    @completion   = "Please make your move"
  end
   
  def update(model)
     (0..8).to_a.each do | position |
       value = model.condition[position]
       @representation.sub!(Regexp.new(position.to_s), value) if (value !~ /[0-8]/)
     end
  end
end