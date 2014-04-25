class AccountValidator

  ERR = 'ERR'
  ILLEGAL = 'ILL'
  def initialize

  end

  def check_sum?(acc_number)
    sum(acc_number) % 11 == 0
  end

  def update_account_status(acc_number)
 
    if acc_number.contains?('?')
      acc_number.set_status(ILLEGAL)
      elsif !check_sum?(acc_number)
          acc_number.set_status(ERR)
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
