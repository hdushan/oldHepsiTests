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
    run_cucumber_tests_first_try(feature_to_run, "results.html")
  rescue Exception => e
    puts "\n\n***** Rerunning failed scenarios in feature #{feature_to_run} *****\n\n"
    puts "\n\n***** Scenarios that will be rerun: *****"
    scenario_list = File.new(rerun_file, "r")
    while (scenario = scenario_list.gets)
      puts "*****    - #{scenario.strip} *****\n\n"
    end
    run_cucumber_tests_second_try(rerun_file, "results_of_retry.html")
  end
end

desc "Run a feature file, and rerun it if it failed"
task :feature_run_with_host, [:feature_name,:host_environment] do |t, args|
  feature_to_run = "features" + "/" + "#{args[:feature_name]}.feature"
  ENV['environment'] = args[:host_environment]
  rerun_file = "rerun.txt"
  puts "\n\n***** Running feature file #{feature_to_run} on Environment: #{ENV['environment']} *****\n\n"
  begin
    run_cucumber_tests_first_try(feature_to_run, "results.html")
  rescue Exception => e
    puts "\n\n***** Rerunning failed scenarios in feature #{feature_to_run} *****\n\n"
    puts "\n\n***** Scenarios that will be rerun: *****"
    scenario_list = File.new(rerun_file, "r")
    while (scenario = scenario_list.gets)
      puts "*****    - #{scenario.strip} *****\n\n"
    end
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
  report_file = "loadtest_report.csv"
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
    run_load_test(loadtest_script, result_file, "csv", report_file, options)
    check_for_errors("csv", report_file, 98)
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
  report_file = "loadtest_mobile_report.csv"
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
    run_load_test(loadtest_script, result_file, "csv", report_file, options)
    check_for_errors("csv", report_file, 98)
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
  report_file = "warmup_report.csv" #leave as '' if you dont create a html report
  options = {}
  options["SERVER_URL"] = args[:server_url] if not args[:server_url].nil?
  begin
    run_load_test(loadtest_script, result_file, "csv", report_file, options)
  rescue => e
    puts e.to_s
    abort("\nWarmup Load test not successful\n")
  end  
end

def check_for_errors(report_file_format, report_file, threshold)
  case report_file_format
    when "html"
      require 'nokogiri'
      page = Nokogiri::HTML(open(report_file))
      puts page.text.include?("Test Results")
      pass_percent = page.css(".details")[0].css("td")[2].text.split("%")[0].to_i
    when "csv"
      require 'csv'
      result_table = CSV.table(report_file)
      puts "\n\n"
      puts result_table
      puts "\n\n"
      last_row_that_has_totals = result_table[-1]
      total_error_rate_as_a_percentage = last_row_that_has_totals.to_hash[:aggregate_report_error]*100
      pass_percent = 100-total_error_rate_as_a_percentage
    else
      puts "\n\nWarning: Invalid report format \'#{report_file_format}\'. Cannot calculate pass percentage!!\n\n"
  end
  if defined? pass_percent
    puts "\n\nOverall Pass percentage: #{pass_percent}%\n\n"
    if pass_percent < threshold
      raise "\n\nFAIL!!!!!!\nPass percentage of http requests (#{pass_percent}%) is less than the expected threshold (#{threshold}%)\n\n"
    end
  end  
end

def run_load_test(loadtest_file, loadtest_result_file, loadtest_report_format, loadtest_report_file, options='')
  jmeter_result_format = "xml"
  testRunner = JmeterTestRunner::Test.new(loadtest_file, loadtest_result_file, jmeter_result_format, loadtest_report_format, loadtest_report_file, options)
  testRunner.start()
end