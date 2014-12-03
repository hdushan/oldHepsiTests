require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:regression) do |t|
  t.cucumber_opts = "features --format pretty"
end

Cucumber::Rake::Task.new(:inprogress) do |t|
  t.cucumber_opts = "features --format pretty --tags @inprogress"
end