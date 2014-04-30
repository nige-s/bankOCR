require_relative '../lib/acc_number_converter'
require_relative '../lib/account_validator'

describe AccNumberConverter do
  let(:acc_validator)     {AccountValidator.new}
  let(:identifier)        {AccNumberConverter.new(acc_validator)} 
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
