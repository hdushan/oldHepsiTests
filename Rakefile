require 'cucumber'
require 'cucumber/rake/task'

feature_to_run = "features"
cucumber_base_options = "--format pretty --format html --out results.html "
cucumber_command = "#{feature_to_run} #{cucumber_base_options}"

desc "This is a test task"
task :blah, [:param, :param1] do | t, args|
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
  rerun_file = "rerun.txt"
  puts "\n\n***** Running feature file #{feature_to_run} on Server: #{ENV['host']} *****\n\n"
  begin
    ENV["BLAH"] = "test"
    run_cucumber_tests_first_try(feature_to_run, "results.html")
  rescue Exception => e
    puts "\n\n***** Rerunning failed scenarios in feature #{feature_to_run} *****\n\n"
    puts "\n\n***** Scenarios that will be rerun: *****"
    scenario_list = File.new(rerun_file, "r")
    while (scenario = scenario_list.gets)
      puts "*****    - #{scenario.strip} *****\n\n"
    end
    ENV["BLAH"] = "hans"
    run_cucumber_tests_second_try(rerun_file, "results_of_retry.html")
  end
end

def run_cucumber_tests_first_try(feature_to_run, results_file)
  Cucumber::Rake::Task.new("cucumber_first_try") do |t|
    cucumber_base_options = "--format pretty --format html --out #{results_file} --format rerun --out rerun.txt "
    t.cucumber_opts = "#{feature_to_run} #{cucumber_base_options}"
    puts "t.cucumber_opts = #{t.cucumber_opts}"
  end
  Rake::Task["cucumber_first_try"].invoke()
end

def run_cucumber_tests_second_try(rerun_file, results_file)
  Cucumber::Rake::Task.new("cucumber_retry") do |t|
    cucumber_base_options = "--format pretty --format html --out #{results_file} "
    t.cucumber_opts = "@#{rerun_file} #{cucumber_base_options}"
    puts "t.cucumber_opts = #{t.cucumber_opts}"
  end
  Rake::Task["cucumber_retry"].invoke()
end

desc "Run Jmeter Performance Tests (Desktop)"
task :performance, [:server_url, :max_load, :ramup_up, :duration] do |t, args |
  require 'jmeter-test-runner'
  puts "Running Load Test"
  loadtest_script = "performance/loadtest.jmx"
  result_file = "loadtest_results.jtl"
  result_file_html = "loadtest_results.html"
  options = {}
  if (args[:server_url].nil? != true) and (args[:server_url].empty? != true)
    options["SERVER_URL"] = args[:server_url] if not args[:server_url].nil?
  end
  if (args[:max_load].nil? != true) and (args[:max_load].empty? != true)
    options["MAX_LOAD"] = args[:max_load] 
  end
  if (args[:ramup_up].nil? != true) and (args[:ramup_up].empty? != true)
    options["RAMP_UP"] = args[:ramup_up]
  end
  if (args[:duration].nil? != true) and (args[:duration].empty? != true)
    options["DURATION"] = args[:duration] 
  end
  puts options
  begin
    run_load_test(loadtest_script, result_file, "xml", result_file_html, options)
    check_for_errors(result_file_html, 98)
  rescue => e
    puts e.to_s
    abort("\nLoad test not successful\n")
  end  
end

desc "Run Jmeter Performance Tests (Mobile)"
task :mobile_performance, [:server_url, :max_load, :ramup_up, :duration] do |t, args |
  require 'jmeter-test-runner'
  puts "Running Mobile Load Test against server: #{args[:server_url]} for duration: #{args[:duration]} secs with max concurrent users: #{args[:max_load]} and ramping up in #{args[:ramup_up]} secs"
  loadtest_script = "performance/loadtest_mobile.jmx"
  result_file = "loadtest_mobile_results.jtl"
  result_file_html = "loadtest_mobile_results.html"
  options = {}
  if (args[:server_url].nil? != true) and (args[:server_url].empty? != true)
    options["SERVER_URL"] = args[:server_url] if not args[:server_url].nil?
  end
  if (args[:max_load].nil? != true) and (args[:max_load].empty? != true)
    options["MAX_LOAD"] = args[:max_load] 
  end
  if (args[:ramup_up].nil? != true) and (args[:ramup_up].empty? != true)
    options["RAMP_UP"] = args[:ramup_up]
  end
  if (args[:duration].nil? != true) and (args[:duration].empty? != true)
    options["DURATION"] = args[:duration] 
  end
  puts options
  begin
    run_load_test(loadtest_script, result_file, "xml", result_file_html, options)
    check_for_errors(result_file_html, 98)
  rescue => e
    puts e.to_s
    abort("\nMobile Load test not successful\n")
  end  
end

desc "Run Jmeter Warmup Tests"
task :warmup, [:server_url] do |t, args |
  require 'jmeter-test-runner'
  puts "Running Warmup Load Test"
  loadtest_script = "performance/warmup.jmx"
  result_file = "warmup_results.jtl"
  result_file_html = "warmup_results.html" #leave as '' if you dont create a html report
  options = {}
  options["SERVER_URL"] = args[:server_url] if not args[:server_url].nil?
  begin
    run_load_test(loadtest_script, result_file, "xml", result_file_html, options)
  rescue => e
    puts e.to_s
    abort("\nWarmup Load test not successful\n")
  end  
end

desc "Run Jmeter Warmup Tests"
task :warmup_journey, [:server_url] do |t, args |
  require 'jmeter-test-runner'
  puts "Running Warmup Load Test"
  loadtest_script = "performance/warmup_journey.jmx"
  result_file = "warmup_journey_results.jtl"
  result_file_html = "" #ie dont create a html report
  options = {}
  options["SERVER_URL"] = args[:server_url] if not args[:server_url].nil?
  begin
    run_load_test(loadtest_script, result_file, "xml", result_file_html, options)
  rescue => e
    puts e.to_s
    abort("\nWarmup Load test not successful\n")
  end  
end

desc "Run Jmeter Warmup Tests"
task :warmup_regression, [:server_url] do |t, args |
  require 'jmeter-test-runner'
  puts "Running Warmup Load Test"
  loadtest_script = "performance/warmup_regression.jmx"
  result_file = "warmup_regression_results.jtl"
  result_file_html = "" #ie dont create a html report
  options = {}
  options["SERVER_URL"] = args[:server_url] if not args[:server_url].nil?
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