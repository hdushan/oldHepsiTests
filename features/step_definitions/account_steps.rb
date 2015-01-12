#encoding: UTF-8
When(/^I click the account icon$/) do
  Capybara.page.driver.browser.manage.window.resize_to(1024,768)
  sleep 2
  find_by_id('myAccount').click
  find_by_id('login').click
end

Then(/^I should be redirected to a log\-in page$/) do
  pending
end