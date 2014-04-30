require_relative '../lib/account_number'

class StringAccountNumber < AccountNumber
  attr_reader :string_number
  
  def initialize(acc_num)
    @string_number = acc_num
    super
  end

  def set_number(str_num)
    @string_number = str_num
  end

  def each_digit
    @string_number.each {|digit| yield digit }
  end

end
