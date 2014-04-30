class AccountValidator
  attr_reader :unknown, :multiple, :amb, :err, :ill

  def initialize
    @unknown = '?'
    @multiple = '$'
    @amb = 'AMB'
    @err = 'ERR'
    @ill = 'ILL'
  end

  def check_sum?(acc_number)
    acc_number.account_number.include?(@unknown) ? false : sum(acc_number) % 11 == 0
  end

  def update_account_status(acc_number)
    acc_number.reset_status

    if acc_number.contains?(@unknown) 
      acc_number.set_status(@ill)
    else
      if acc_number.alternates_count > 1 
	acc_number.set_status(@amb)
      end
      if !check_sum?(acc_number)
	acc_number.set_status(@err)
      end
    end
  end

  def sum(acc_num)
    multiplier = 9
    total = 0
    acc_num.each_int do |d|
      total += d.to_i * multiplier
      multiplier -= 1
    end
    total
  end
end  
