require 'cucumber'
require 'cucumber/rake/task'

cucumber_base_options = "features --format pretty --format html --out results.html "

Cucumber::Rake::Task.new(task_name="regression", desc="Run all tests except the ones inprogress") do |t|
  t.cucumber_opts = cucumber_base_options + "--tags ~@flaky"
end

Cucumber::Rake::Task.new(task_name="inprogress", desc="Run all inprogress tests only") do |t|
  t.cucumber_opts = cucumber_base_options + "--tags @inprogress"
end

Cucumber::Rake::Task.new(task_name="flaky", desc="Run all inprogress tests only") do |t|
  t.cucumber_opts = cucumber_base_options + "--tags @flaky"
end

desc "Run tests tagged with the story number, Usage example: rake story[36]"
task :story, [:storynum] do |t, args|
  Cucumber::Rake::Task.new(:cucumber) do |t|
    t.cucumber_opts = cucumber_base_options + "--tags @#{args[:storynum]}"
  end
  Rake::Task[:cucumber].invoke()
end

desc "Run Jmeter Performance Tests"
task :performance do |t |
  require 'jmeter-test-runner'
  puts "Running Load Test"
  loadtest_script = "performance/loadtest.jmx"
  result_file = "loadtest_results.jtl"
  result_file_html = "loadtest_results.html"
  run_load_test(loadtest_script, result_file, "xml", result_file_html)
  check_for_errors(result_file_html, 98)
end

def check_for_errors(result_file_html, threshold)
  require 'nokogiri'
  page = Nokogiri::HTML(open(result_file_html)) 
  puts page.text.include?("Test Results")
  pass_percent = page.css(".details")[0].css("td")[2].text.split("%")[0].to_i
  if pass_percent < threshold
    puts "\n\nFAIL!!!!!!\nPass percentage of http requests (#{pass_percent}%) is less than the expected threshold (#{threshold}%)\n\n"
    raise
  end  
end

def run_load_test(loadtest_path, loadtest_result_path, loadtest_result_format, loadtest_html_result_path)
  testRunner = JmeterTestRunner::Test.new(loadtest_path, loadtest_result_path, loadtest_result_format, loadtest_html_result_path)
  testRunner.start()
end

task :default => [:regression]