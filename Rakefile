require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:regression) do |t|
  t.cucumber_opts = "features --format pretty"
end

Cucumber::Rake::Task.new(:run36) do |t|
  t.cucumber_opts = "features --format pretty --tags @36"
end