require_relative '../lib/acc_Number_reader'

describe AccNumberReader do
  puts 
  input_file = 'input/acc_uniq_digits.input'
  let(:acc_reader) {AccNumberReader.new(input_file)}
  context "with account number using all digits" do
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

      "   "+
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

    it "returns 9 correctly read in unique digits" do
      account_number = acc_reader.first
      index = 0
      account_number.each do |acc_number|
	acc_number[index].should == digits[index + 1]
	index += 1
      end
    end
  end
end
