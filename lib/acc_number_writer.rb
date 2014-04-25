class AccNumberWriter
  
  def initialize(file_path)
    @file_path = file_path
  end

  def out(acc_numbers)
    File.open(@file_path, 'w') do |file|
      acc_numbers.each do |acc_num|
        file.puts acc_num.to_string
	

      end
    end
  end
end
