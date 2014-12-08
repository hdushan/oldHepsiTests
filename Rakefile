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

task :default => [:regression]