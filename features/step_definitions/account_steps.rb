# encoding: UTF-8
When(/^I click the account icon$/) do
  click_link "myAccount"
end

Then(/^I should be redirected to a log\-in page$/) do
  expect(find("#login-container"))
end