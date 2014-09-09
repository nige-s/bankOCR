require_relative '../lib/acc_number_reader'
require_relative '../lib/acc_number_converter'
require_relative '../lib/account_validator'
require_relative '../lib/acc_number_writer'


describe AccNumberWriter do
  input_file =     'input/invalid_illegal_acc.input'
  output_file =    'output/invalid_illegal_test.op'
  output2_file =   'output/invalid_illegal_test2.op'
  expected_file =  'input/invalid_illegal_test_expected.input'
  expected_file2 = 'input/invalid_illegal_test2_expected.input'

  let(:acc_number_reader) {AccNumberReader.new(input_file,9)}
  let(:acc_validator)     {AccountValidator.new}
  let(:acc_writer)        {AccNumberWriter.new(output_file)}
  let(:converter)         {AccNumberConverter.new(acc_validator)} 

  context "with invalid and illegal account numbers" do
    it "updates acc number status and writes out to file with errors printed" do
      acc_number_reader.each do |account|
       account.set_account_number(converter.to_single_line(account))
       acc_validator.update_account_status(account)
      end
      results = Array.new
      expected = Array.new

        acc_writer.out(acc_number_reader.account_numbers)  
        File.open(output_file).readlines.each do |line|
          results.push(line.strip)
	end
        File.open(output_file).readlines.each do |line|
          expected.push(line.strip)
	end
      (0..results.count).each do |index|
        expect(results[index]).to eq(expected[index])
      end
    end

    it "checks account numbers returned with errors and attempts to identify corrections" do
      acc_number_reader.each do |account|
       account.set_account_number(converter.to_single_line(account))
       acc_validator.update_account_status(account)
       if account.status == acc_validator.err || account.status == acc_validator.ill
	 converter.process_errors(account) 
       end
      end
      results2 = Array.new
      expected = Array.new

        acc_writer.file_path = output2_file
        acc_writer.out(acc_number_reader.account_numbers)  
        File.open(output2_file).readlines.each do |line|
          results2.push(line.strip)
	end

	File.open(expected_file2).readlines.each do |line|
          expected.push(line.strip)   
	end

      (0..results2.count).each do |index|
        expect(results2[index]).to eq(expected[index])
      end
    end
  end
end
