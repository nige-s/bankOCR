class AccNumberReader
  attr_accessor :account_number

  def initialize(file_path)
    @file_path = file_path
    @acc_index = 0 
    @account_number  = Array.new(8) {Array.new(10) {""}}
    #read_account_numbers
  end

  def account_number
    @account_number
  end

  def first
    @account_number[0]
  end
  
  def read_account_numbers
    file = File.open(@file_path, "r+")
    while !file.eof?
      3.times do
	line = file.readline
	build_digits(line)
    end
      file.readline
      @acc_index += 1
    end
  end
    def build_digits(line)
      digit = 0
      digit_third = line.gsub(/.../)
       digit_third.each do |section|
         @account_number[@acc_index][digit] << section
	digit += 1
      end
    end
end
