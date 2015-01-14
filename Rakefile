require 'cucumber'
require 'cucumber/rake/task'

feature_to_run = "features"
cucumber_base_options = "--format pretty --format html --out results.html "
cucumber_command = "#{feature_to_run} #{cucumber_base_options}"

desc "This is a test task"
task :test, [:param, :param1] do | t, args|
  puts "Hello #{args[:param]}, #{args[:param1]}"
end

desc "Run tests tagged with the story number, Usage example: rake story[36]"
task :story, [:storynum] do |t, args|
  Cucumber::Rake::Task.new(:cucumber_story) do |t|
    t.cucumber_opts = cucumber_command + "--tags @#{args[:storynum]}"
  end
  Rake::Task[:cucumber_story].invoke()
end

desc "Run a feature file, and rerun it if it failed"
task :feature_run, [:feature_name,:host_server] do |t, args|
  feature_to_run = "features" + "/" + "#{args[:feature_name]}.feature"
  ENV['host'] = "http://" + args[:host_server]
  puts "***** Running feature file #{feature_to_run} on Server: #{ENV['host']} *****"
  begin
    Cucumber::Rake::Task.new(:cucumber_feature) do |t| 
      cucumber_base_options = "--format pretty --format html --out results.html "
      t.cucumber_opts = "#{feature_to_run} #{cucumber_base_options}"
      puts "t.cucumber_opts = #{t.cucumber_opts}"
    end
    Rake::Task[:cucumber_feature].invoke()
  rescue => e
    puts e.to_s
    puts "***** Rerunning feature #{feature_to_run} *****"
    Cucumber::Rake::Task.new(:cucumber_feature_retry) do |t|
      cucumber_base_options = "--format pretty --format html --out results_of_retry.html "
      t.cucumber_opts = "#{feature_to_run} #{cucumber_base_options}"
      puts "t.cucumber_opts = #{t.cucumber_opts}"
    end
    Rake::Task[:cucumber_feature_retry].invoke()
  end
end

desc "Run Jmeter Performance Tests"
task :performance, [:server_url] do |t, args |
  require 'jmeter-test-runner'
  puts "Running Load Test"
  loadtest_script = "performance/loadtest.jmx"
  result_file = "loadtest_results.jtl"
  result_file_html = "loadtest_results.html"
  if args[:server_url] != ""
    options = "SERVER_URL=#{args[:server_url]}"
  else
    options = ''
  end
  begin
    run_load_test(loadtest_script, result_file, "xml", result_file_html, options)
    check_for_errors(result_file_html, 98)
  rescue => e
    puts e.to_s
    abort("\nLoad test not successful\n")
  end  
end

desc "Run Jmeter Warmup Tests"
task :warmup, [:server_url] do |t, args |
  require 'jmeter-test-runner'
  puts "Running Warmup Load Test"
  loadtest_script = "performance/warmup.jmx"
  result_file = "warmup_results.jtl"
  result_file_html = "warmup_results.html"
  if args[:server_url] != ""
    options = "SERVER_URL=#{args[:server_url]}"
  else
    options = ''
  end
  begin
    run_load_test(loadtest_script, result_file, "xml", result_file_html, options)
  rescue => e
    puts e.to_s
    abort("\nWarmup Load test not successful\n")
  end  
end

def check_for_errors(result_file_html, threshold)
  require 'nokogiri'
  page = Nokogiri::HTML(open(result_file_html)) 
  puts page.text.include?("Test Results")
  pass_percent = page.css(".details")[0].css("td")[2].text.split("%")[0].to_i
  if pass_percent < threshold
    raise "\n\nFAIL!!!!!!\nPass percentage of http requests (#{pass_percent}%) is less than the expected threshold (#{threshold}%)\n\n"
  end  
end

def run_load_test(loadtest_path, loadtest_result_path, loadtest_result_format, loadtest_html_result_path, options='')
  testRunner = JmeterTestRunner::Test.new(loadtest_path, loadtest_result_path, loadtest_result_format, loadtest_html_result_path, options)
  testRunner.start()
end