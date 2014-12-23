# encoding: UTF-8
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'faker'
require 'capybara-page-object'
require 'pry'
require 'rest-client'

Capybara.app_host = 'http://storefront.qa.hepsiburada.com'#'http://localhost:99'
if ENV['host']
  Capybara.app_host = ENV['host']
end

Capybara.run_server = false
Capybara.default_driver = :firefox
Capybara.default_selector = :css
Capybara.default_wait_time = 60 #default wait time for ajax
Capybara.ignore_hidden_elements = false #ignore hidden elements when testing, make helpful when you hide or show elements using javascript
Capybara.save_and_open_page_path = File.expand_path(File.join(File.dirname(__FILE__), "../../screenshots/"))

module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

World(Capybara::DSL, Helpers)
