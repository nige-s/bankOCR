class AccNumberConverter
  UNKNOWN = '?'
  AMB = 'AMB'
  PIPE = '|'
  U_SCORE = '_'

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
    @converter.key?(digit) ?  @converter[digit] : UNKNOWN
  end

  def to_single_line(str_acc_num)
    output = ''
    str_acc_num.each_digit do|digit|
      output << process_digit(digit)
    end
    output
  end

  def to_3_line(acc_num)

  end

  def guess_digit(digit)
    _positions = [1,4,7]
    found = false
    guessed = guess_replacing_pipes(digit)
    case guess_pipes[:pot]
    when 1
      found = true
      guessed[:status] = AMB
    else
      found = true
      
    end
  end

  def guess_replacing_pipes(digit)
    pipe_positions = [0,2,3,5,6,8]
    guess = {pot: 0, replace: '', status: ''}
    replacement = digit.split(//)

    pipe_positions.each do |index|
      replacement[index] = PIPE unless replacement[index] == PIPE
      result = digit_to_number
      if result != UNKNOWN
        guess[:pot] += 1
	guess[:replace] = result unless guess[:pot] > 1
      end
    end
  end

  def process_digit(digit) 
    digit_to_number(digit) == UNKNOWN ? guess_digit(digit) : UNKNOWN
  end
end
