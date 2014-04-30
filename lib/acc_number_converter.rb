require_relative '../lib/account_validator'

class AccNumberConverter
  PIPE = '|'
  U_SCORE = '_'
  BLANK = ' '
  
  def initialize(validator)
    @validator = validator
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
    @converter.key?(digit) ?  @converter[digit] : @validator.unknown
  end

  def process_digit(digit) 
   result = digit_to_number(digit) 
   result == @validator.unknown ? guess_digit(digit) : result
  end

  def to_single_line(str_acc_num)
    output = ''
    str_acc_num.each_digit do|digit|
      output << digit_to_number(digit)
      str_acc_num.set_status(@status)  
    end
    output
  end
  
  def check_errors(acc_number)
   valid_options = 0
   str_num_arr =  acc_number.string_number.inject([]) { |a,element| a << element.dup }
   number_arr = acc_number.account_number.split(//)
   str_potentials = Array.new
    if acc_number.status == @validator.err || acc_number.status == @validator.ill
      (0..8).each do |index|
        options = options_for_digit(str_num_arr[index])

	  options.each do |sub|
            tmp_num  =  number_arr.inject([]) { |a,element| a << element.dup }
	    tmp_num[index] = sub
	    acc =  AccountNumber.new(tmp_num.join)
            if @validator.check_sum?(acc)
              valid_options += 1
	      str_potentials.push(acc.account_number)
	    end
	  end
      end
      if valid_options == 1
        acc_number.set_account_number(str_potentials[0])
      elsif valid_options > 1
        acc_number.set_account_number(str_potentials[0])
      end
        str_potentials.each do |element| 
	 acc_number.add_alternate_number(element.dup) 
         @validator.update_account_status(acc_number)
       end
    end

  end
  def is_potential?(option)
      res = digit_to_number(option.join)
      res != @validator.unknown ?  res : @validator.unknown
  end



  
  def options_for_digit(digit)
    replacement = digit.split(//)
    options = Array.new

    (0..8).each do |index|
      char =  replacement[index]
      case index
	when 0,2 
	  if char == PIPE || char == U_SCORE
	    replacement[index] = BLANK
	    is_potential?(replacement)
	  end
	    replacement[index] = char
	when 1,4,7
	  
	  if char != U_SCORE
	    replacement[index] = U_SCORE
	    is_potential?(replacement)
	  end
	    replacement[index] = char
	when 3,5,6,8

	  if char !=  PIPE
	    replacement[index] = PIPE
	    is_potential?(replacement)
	  end
	    replacement[index] = char
      end
    end
  end
  
=begin
  def guess_options(digit)
    guess = {pot: 0, replace: @validator.unknown}
    replacement = digit.split(//)
    
    (0..8).each do |index|
      char =  replacement[index]
      case index
	when 0,2 
	  if char == PIPE || char == U_SCORE
	    replacement[index] = BLANK
	    guess = check_potential(replacement,guess)
	  end
	    replacement[index] = char
	when 1,4,7
	  
	  if char != U_SCORE
	    replacement[index] = U_SCORE
	    guess = check_potential(replacement,guess)
	  end
	    replacement[index] = char
	when 3,5,6,8

	  if char !=  PIPE
	    replacement[index] = PIPE
	    guess = check_potential(replacement,guess)
	  end
	    replacement[index] = char
      end
    end
    guess
  end

  def guess_digit(digit) 
    found = false
    guessed = guess_options(digit)
    number = if guessed[:pot] == 1
	       number = guessed[:replace]
             elsif guessed[:pot] > 1
               @validator.unknown
             else
               @validator.unknown
              end
  end
=end
end
