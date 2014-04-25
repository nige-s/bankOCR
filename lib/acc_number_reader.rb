require_relative '../lib/string_acc_number'
class AccNumberReader
  attr_accessor :account_numbers
  attr_reader :test_3line_acc
  def initialize(file_path, acc_length)
    @file_path = file_path
    @test_3line_acc = [
          " _ "+
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

    @acc_index = 0 
    @account_numbers  = Array.new
    read_account_numbers(acc_length)
  end

  def account_number
    @account_number
  end

  def first
    @account_numbers[0]
  end
  
  def each
    @account_numbers.each do |acc_num|
      yield acc_num
    end
  end

  private

  def read_account_numbers(acc_length)
    file = File.open(@file_path, "r+")
    while !file.eof?
    tmp_number = Array.new(acc_length) {""}
      3.times do
	build_digits(file.readline,tmp_number)
    end
      file.readline unless file.eof?
      @account_numbers.push(StringAccountNumber.new(tmp_number))
      @acc_index += 1
    end
    file.close
  end
    def build_digits(line, acc_number)
      index = 0
      digit_third = line.gsub(/.../)
       digit_third.each do |section|
         acc_number[index] << section
 	 index += 1
      end
    end
end
