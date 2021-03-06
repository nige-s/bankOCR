class AccountNumber
  attr_reader :account_number, :status
  attr_accessor :alternates 
  
  def initialize(acc_num='')
    @account_number = acc_num
    @alternates = Array.new
  end

  def set_account_number(acc_num)
    @account_number = acc_num
  end

  def add_alternate_number(number)
    @alternates.push(number)   
  end

  def alternates_count
    @alternates.count
  end

  def contains?(char)
    @account_number.include?(char)
  end

  def to_string
    "#{@account_number} #{@status}"
  end
  
  def each_int
    @account_number.split(//).each {|digit| yield digit }
  end

  def each_digit
    splitz = @account_number.split(//)
    splitz.each {|digit| yield digit }
  end

  def set_status(status)
    @status = status
  end

  def reset_status
    @status = ''
  end
end
