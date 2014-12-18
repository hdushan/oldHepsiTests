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
  require_relative 'performance/jmeter-test-runner'
  puts "Running Load Test"
  #time_now=Time.now
  loadtest_script = "performance/loadtest.jmx"
  #result_file = "loadtest_results_" + time_now.strftime("%d%m%y_%H%M%S") + ".jtl"
  #result_file_html = "loadtest_results_" + time_now.strftime("%d%m%y_%H%M%S") + ".html"
  result_file = "loadtest_results.jtl"
  result_file_html = "loadtest_results.html"
  run_load_test(loadtest_script, result_file, "xml", result_file_html)
end

def run_load_test(loadtest_path, loadtest_result_path, loadtest_result_format, loadtest_html_result_path)
  testRunner = JmeterTestRunner::Test.new(loadtest_path, loadtest_result_path, loadtest_result_format, loadtest_html_result_path)
  testRunner.start()
end

task :default => [:regression]