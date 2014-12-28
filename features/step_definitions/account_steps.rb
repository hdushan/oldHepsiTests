#encoding: UTF-8
When(/^I click the account icon$/) do
  find_by_id('myAccount').first('span').click
  find_by_id('login').click
end

Then(/^I should be redirected to a log\-in page$/) do
  pending
end