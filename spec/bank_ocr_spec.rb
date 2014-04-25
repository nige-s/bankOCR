require_relative '../lib/acc_number_reader'
require_relative '../lib/acc_number_converter'
require_relative '../lib/account_validator'
require_relative '../lib/acc_number_writer'

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
  let(:acc_reader) {AccNumberReader.new(input_file,10)}
  let(:converter) {AccNumberConverter.new} 
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

describe AccNumberConverter do
 let(:identifier) {AccNumberConverter.new} 
  context "with correctly formed digit - 0" do
    it "returns an integer - 0" do
      digit = " _ | ||_|"
      identifier.digit_to_number(digit).should == '0'
    end
  end
  context "with incorrectly formed digit - 0" do
    it "returns nil" do
      digit = " _ |     "
      identifier.digit_to_number(digit).should == '?'
    end
  end
end
describe AccountValidator do
let(:acc_validator) {AccountValidator.new}
valid_number =       AccountNumber.new('457508000')#'345882865')
invalid_number =     AccountNumber.new('664371495')


  context "with valid account number" do
    it "returns true" do
      acc_validator.check_sum?(valid_number).should be_true
    end
  end

  context "with invalid account number" do
   it "returns false" do
     acc_validator.check_sum?(invalid_number).should_not be_true
   end
  end
end

describe AccNumberWriter do
  input_file = 'input/invalid_illegal_acc.input'
  output_file = 'output/invalid_illegal_test.op'
  let(:acc_number_reader) {AccNumberReader.new(input_file,9)}
  let(:acc_validator)     {AccountValidator.new}
  let(:acc_writer)        {AccNumberWriter.new(output_file)}
  let(:converter)         {AccNumberConverter.new} 
  reference = ['00???0000 ILL','111111111 ERR','222??2222 ILL','664371495 ERR','457508000']

  context "with invalid and illegal account numbers" do
    it "updates acc number status and writes out to file with errors printed" do
      acc_number_reader.each do |account|
       account.set_account_number(converter.to_single_line(account))
           acc_validator.update_account_status(account)
      end
      results = Array.new
        acc_writer.out(acc_number_reader.account_numbers)  
        File.open(output_file).readlines.each do |line|
          results.push(line.strip)
	end
      (0..results.count).each do |index|
        results[index].should == reference[index]
      end
    end
  end
end
