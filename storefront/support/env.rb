require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'faker'
require 'capybara-screenshot'
require 'capybara-screenshot/cucumber'
require 'capybara-page-object'
require 'site_prism'

Capybara.app_host = 'http://storefront.qa.hepsiburada.com'#'http://localhost:99'
Capybara.run_server = true
Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_selector = :css
Capybara.default_wait_time = 5 #default wait time for ajax
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
