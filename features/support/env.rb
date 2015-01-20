#encoding: UTF-8
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'faker'
require 'capybara-page-object'
require 'rest-client'
require 'tiny_tds'
require 'time_diff'
#require 'capybara/poltergeist'
require 'yaml'

def test_data_files(dir)
  Dir.entries(dir).select{|entry| entry =~ /yml$/}
end

def is_test_data_consistent?(data_folder)
  raise "\n\nTest Data file for the environment #{ENV['environment']} is not found in folder #{data_folder}\n\n" unless test_data_files(data_folder).include? "#{ENV['environment']}.yml"
end

test_data_folder = File.join(Dir.pwd, "features", "test_data")

#is_test_data_consistent?(test_data_folder)

#$test_data = YAML.load_file(File.join(test_data_folder), "#{ENV["environment"]}.yml")

#puts $test_data.keys

Capybara.app_host = 'http://storefront.qa.hepsiburada.com'#'http://localhost:99'
if ENV['host']
  Capybara.app_host = ENV['host']
end

Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_wait_time = 180 #default wait time for ajax
Capybara.ignore_hidden_elements = false #ignore hidden elements when testing, make helpful when you hide or show elements using javascript
Capybara.save_and_open_page_path = File.expand_path(File.join(File.dirname(__FILE__), "../../screenshots/"))

def is_windows?
  (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
end

def is_mac?
  (/darwin/ =~ RUBY_PLATFORM) != nil
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :phantomjs)
end

#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, {js_errors:false, phantomjs_options:['--proxy-type=none'], timeout:180})
#end

Capybara.default_driver = :selenium
Capybara.current_driver = :selenium
Capybara.javascript_driver = :selenium
begin
  #page.driver.resize_window(1920, 1080)
  Capybara.page.driver.browser.manage.window.maximize
rescue Exception => e
  p "Unable to maximise window!!!"
  p e.to_s
end

World(Capybara::DSL)
