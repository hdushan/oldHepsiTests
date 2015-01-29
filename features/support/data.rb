
def test_data_files(dir)
  Dir.entries(dir).select{|entry| entry =~ /yml$/}
end

def is_test_data_folder_consistent?(data_folder)
  raise "\n\nTest Data Error: Test Data file for the environment \"#{ENV['environment']}\" is not found in folder \"#{data_folder}\"\n\n" unless test_data_files(data_folder).include? "#{ENV['environment']}.yml"
end

def is_test_data_valid?(data)
  puts data
  raise "\n\nTest Data Error: The test data file \"#{ENV['environment']}.yml\" does not contain a SERVER_URL\n\n" if data["SERVER_URL"].nil?
  raise "\n\nTest Data Error: SERVER_URL in the test data file \"#{ENV['environment']}.yml\" does not contain \"http://\"\n\n" unless data["SERVER_URL"].include?("http://")
end

def is_test_data_consistent_with_all_other_data_files?(data,folder)
  data_files = test_data_files(folder)
  data_files.each do |data_file|
    curr_data = YAML.load_file(File.join(folder, data_file))
    if curr_data.keys.sort != data.keys.sort
      raise "\n\nTest Data Error: Some data keys are inconsistent in data file \"#{data_file}\". Keys inconsistent are: #{(curr_data.keys-data.keys) | (data.keys-curr_data.keys)}\n\n"
    end
  end
end

def read_test_data_file(environment)
  is_test_data_folder_consistent?($test_data_folder)
  data = YAML.load_file(File.join($test_data_folder, "#{environment}.yml"))
  is_test_data_valid?(data)
  is_test_data_consistent_with_all_other_data_files?(data,$test_data_folder)
  return data
end

def get_test_data(data_key)
  raise "\n\n Test Data Error: No test data found for key \"data_key\"\n\n" if $test_data[data_key].nil?
  return $test_data[data_key]
end