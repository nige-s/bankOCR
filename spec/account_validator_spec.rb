require_relative '../lib/account_validator'
require_relative '../lib/acc_number_writer'
require_relative '../lib/account_number'

describe AccountValidator do
let(:acc_validator) {AccountValidator.new}
valid_number =       AccountNumber.new('457508000')#'345882865')
invalid_number =     AccountNumber.new('664371495')


  context "with valid account number" do
    it "returns true" do
      res = acc_validator.check_sum?(valid_number)
      expect(res).to be_truthy
    end
  end

  context "with invalid account number" do
   it "returns false" do
     res = acc_validator.check_sum?(invalid_number)
     expect(res).to be_falsey
   end
  end
end

