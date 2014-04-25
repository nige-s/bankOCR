class AccNumberConverter
  
  def initialize
      @converter = {" _ | ||_|" => '0',
	            "     |  |" => '1',
		    " _  _||_ " => '2', 
		    " _  _| _|" => '3',
		    "   |_|  |" => '4',
		    " _ |_  _|" => '5', 
		    " _ |_ |_|" => '6',
		    " _   |  |" => '7',
		    " _ |_||_|" => '8', 
		    " _ |_| _|" => '9'}
  end

  def digit_to_number(digit)
    @converter.key?(digit) ?  @converter[digit] : '?'
  end

  def to_single_line(str_acc_num)
    output = ''
    str_acc_num.each_digit { |digit| output << digit_to_number(digit) }
    output
  end

  def to_3_line(acc_num)

  end
end
