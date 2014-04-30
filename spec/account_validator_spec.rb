require_relative '../lib/account_validator'
require_relative '../lib/acc_number_writer'

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

