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

describe AccNumberConverter do
  let(:acc_validator)     {AccountValidator.new}
  let(:acc_converter)     {AccNumberConverter.new(acc_validator)} 
  context "with correctly formed digit - 0" do
    it "returns an integer - 0" do
      digit = " _ | ||_|"
      acc_converter.digit_to_number(digit).should == '0'
    end
  end
  context "with incorrectly formed digit - 0" do
    it "returns nil" do
      digit = " _ |     "
      acc_converter.digit_to_number(digit).should == '?'
    end
  end

  context "with a 9 character account number string" do
    it "returns a 3 line/9 character  account number in an array" do
      account_number = "0123456789"
      expected = Array.new
      converted_arr = acc_converter.to_3_line(account_number)
      (0..9).each do |index|
        converted_arr[index].should == digits[index]
      end
    end
  end
end
