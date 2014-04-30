require_relative '../lib/acc_number_reader'
require_relative '../lib/acc_number_converter'
require_relative '../lib/account_validator'

    digits =
     [" _ "+
      "| |"+
      "|_|",

      "   "+
      "  |"+
      "  |",

      " _ "+
      " _|"+
      "|_ ",

      " _ "+
      " _|"+
      " _|",

      "   "+
      "|_|"+
      "  |",

      " _ "+
      "|_ "+
      " _|",

      " _ "+
      "|_ "+
      "|_|",

      " _ "+
      "  |"+
      "  |",

      " _ "+
      "|_|"+
      "|_|",

      " _ "+
      "|_|"+
      " _|"]

describe AccNumberReader do
  input_file = 'input/acc_uniq_digits.input'
  let(:acc_validator)     {AccountValidator.new}
  let(:acc_reader)        {AccNumberReader.new(input_file,10)}
  let(:converter)         {AccNumberConverter.new(acc_validator)} 
  context "with account number using all digits" do
    it "returns 9 correctly read in unique digits" do
      str_acc_number = acc_reader.first
      index = 0
      str_acc_number.each_digit do |digit|
	digit.should == digits[index]
	index += 1
      end
    end

    it "converts each digit into it's integer counterpart" do
      str_acc_number = acc_reader.first
      index = 0
        str_acc_number.each_digit do |digit|
          converter.digit_to_number(digit).should == index.to_s
        index += 1
      end
    end

    it "converts a read-in digit acc number and returns an integer version" do
      str_acc_number = acc_reader.first
      converter.to_single_line(str_acc_number). should == "0123456789"
    end
  end
end

describe AccNumberReader do 
  input_file = 'input/user_story_1.input'
  let(:acc_number_reader) {AccNumberReader.new(input_file,9)}
  context "with 10 account numbers using 1 digit for all 9 numbers incrementing consecutively" do
    it "returns correct digits for each account number" do
      acc_index = 0
      acc_number_reader.each do |str_number|
        str_number.each_digit do |digit|
          digit.should == digits[acc_index]
	end
	acc_index += 1
      end
    end
  end

end

