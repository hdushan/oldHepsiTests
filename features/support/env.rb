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
require 'capybara/poltergeist'

Capybara.app_host = 'http://storefront.qa.hepsiburada.com'#'http://localhost:99'
if ENV['host']
  Capybara.app_host = ENV['host']
end

Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_wait_time = 60 #default wait time for ajax
Capybara.ignore_hidden_elements = false #ignore hidden elements when testing, make helpful when you hide or show elements using javascript
Capybara.save_and_open_page_path = File.expand_path(File.join(File.dirname(__FILE__), "../../screenshots/"))

# module Helpers
#   def without_resynchronize
#     page.driver.options[:resynchronize] = false
#     yield
#     page.driver.options[:resynchronize] = true
#   end
# end

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors:false, phantomjs_options:['--proxy-type=none'], timeout:180})
end

Capybara.default_driver = :firefox
Capybara.current_driver = :firefox
Capybara.javascript_driver = :firefox

World(Capybara::DSL)
