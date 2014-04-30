require_relative '../lib/account_validator'

class AccNumberConverter
  PIPE = '|'
  U_SCORE = '_'
  BLANK = ' '
  
  def initialize(validator)
    @validator = validator
    @multiple_char_to_single = {" _ | ||_|" => '0',
				"     |  |" => '1',
				" _  _||_ " => '2', 
				" _  _| _|" => '3',
				"   |_|  |" => '4',
				" _ |_  _|" => '5', 
				" _ |_ |_|" => '6',
				" _   |  |" => '7',
				" _ |_||_|" => '8', 
				" _ |_| _|" => '9'}
    @single_to_multiple_char_= {'0' => " _ | ||_|",
			        '1' => "     |  |",
				'2' => " _  _||_ ", 
				'3' => " _  _| _|",
				'4' => "   |_|  |",
				'5' => " _ |_  _|", 
				'6' => " _ |_ |_|",
				'7' => " _   |  |",
				'8' => " _ |_||_|", 
				'9' => " _ |_| _|"}
  end

  def process_errors(acc_number)
   valid_options = 0
   str_num_arr = array_copy(acc_number.string_number)
   number_arr = acc_number.account_number.split(//)
   str_potentials = Array.new
    if acc_number.status == @validator.err || acc_number.status == @validator.ill
      potential_account_numbers(str_num_arr,number_arr) { |pot_number| str_potentials.push(pot_number)}
      if  str_potentials.count == 1
        acc_number.set_account_number(str_potentials[0])
      elsif str_potentials.count > 1
        acc_number.set_account_number(str_potentials[0])
      end
        str_potentials.each do |element| 
	 acc_number.add_alternate_number(element.dup) 
       end
         @validator.update_account_status(acc_number)
    end
  end

  def digit_to_number(digit)
    @multiple_char_to_single.key?(digit) ?  @multiple_char_to_single[digit] : @validator.unknown
  end

  def to_single_line(str_acc_num)
    output = ''
    str_acc_num.each_digit do|digit|
      output << digit_to_number(digit)
    end
    output
  end

  def to_3_line(string_number)
    str_number_arr = Array.new
    number_split = string_number.split(//)

    number_split.each do |char|
       str_number_arr.push(@multiple_char_to_single.key(char))
    end
    str_number_arr
  end
  
  def array_copy(src_array) 
    src_array.inject([]) { |a,element| a << element.dup }
  end

  private

  def process_digit(digit) 
   result = digit_to_number(digit) 
   result == @validator.unknown ? guess_digit(digit) : result
  end

  def potential_account_numbers(acc_array,number_arr)
    (0..8).each do |index|
      replacement_options = options_for_digit(acc_array[index])
	replacement_options.each do |sub|
	  tmp_number  =  array_copy(number_arr)
	  tmp_number[index] = sub
	  acc =  AccountNumber.new(tmp_number.join)
	  if @validator.check_sum?(acc)
	    yield acc.account_number
	  end
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
end
