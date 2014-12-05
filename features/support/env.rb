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
Capybara.run_server = false
Capybara.default_driver = :firefox
Capybara.default_selector = :css
Capybara.default_wait_time = 60 #default wait time for ajax
Capybara.ignore_hidden_elements = false #ignore hidden elements when testing, make helpful when you hide or show elements using javascript
Capybara.save_and_open_page_path = "screenshots/"

module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end

World(Capybara::DSL, Helpers)
