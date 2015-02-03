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
require 'yaml'
require_relative 'data'

$test_data_folder = File.join(Dir.pwd, "features", "test_data")

puts "\n\nENV['host'] = #{ENV['host']}"
puts "\n\nENV['environment'] = #{ENV['environment']}"

unless ENV['environment']
  ENV['environment'] = "test"
end

$test_data = read_test_data_file(ENV["environment"])

if ENV['host']
  Capybara.app_host = ENV['host']
elsif ENV['environment']
  Capybara.app_host = $test_data["SERVER_URL"]
else
  Capybara.app_host = 'http://storefront.test.hepsiburada.com'#'http://localhost:99'
end

puts "\n\nCapybara.app_host = #{Capybara.app_host}\n\n"

Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_wait_time = 30 #default wait time for ajax
Capybara.ignore_hidden_elements = false #ignore hidden elements when testing, make helpful when you hide or show elements using javascript
Capybara.save_and_open_page_path = File.expand_path(File.join(File.dirname(__FILE__), "../../screenshots/"))
$default_wait_time = Capybara.default_wait_time

Capybara::Node::Element.class_eval do
  def click_at(x, y)

      right = x - (native.size.width / 2)
      top = y - (native.size.height / 2)
      driver.browser.action.move_to(native).move_by(right.to_i, top.to_i).click.perform

  end
end

def is_windows?
  (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
end

def is_mac?
  (/darwin/ =~ RUBY_PLATFORM) != nil
end

if ENV['browser']
  $browser_to_use = ENV['browser'].to_sym
else
  $browser_to_use = :phantomjs
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => $browser_to_use)
end

#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(app, {js_errors:false, phantomjs_options:['--proxy-type=none'], timeout:180})
#end

Capybara.default_driver = :selenium
Capybara.current_driver = :selenium
Capybara.javascript_driver = :selenium
begin
  Capybara.current_session.driver.browser.manage.window.resize_to(1920, 1080)
  #Capybara.page.driver.browser.manage.window.maximize
rescue Exception => e
  p "Unable to maximise window!!!"
  p e.to_s
end

World(Capybara::DSL)
