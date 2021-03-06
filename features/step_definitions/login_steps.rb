#encoding: UTF-8

When(/^I login with user "([^"]*)" and pass "([^"]*)"$/) do |arg1, arg2|
  account = find_by_id('myAccount')
  account.hover
  find_by_id('login').click
  visit_link('http://checkout.test.hepsiburada.com/liste/default.aspx')
  find('span', text: "Üye Girişi").click
  find('span', text: "Giriş yap").click
  find_by_id('email').set arg1
  find_by_id('password').set arg2
  find('button', text: "Giriş").click
  sleep 2
  visit_link ""
end

Then(/^I am logged in as "([^"]*)"$/) do |arg|
  account = find_by_id('myAccount')
  account.should have_content arg
  account.click
  account.find_by_id('welcome').should have_content "Merhaba"
  account.find_by_id('LoginUserName').should have_content arg
end

And(/^I get these login options$/) do |table|
  # table is a table.hashes.keys # => []
  values = table.raw[0]
  account = find_by_id('myAccount')
  values.each { |x|
    account.should have_selector('a', text: x)
  }
end

And(/^I log out$/) do
  visit_main_page
  div = find_by_id('myAccount')
  div.hover
  find('a', text: "Çıkış Yap").click
  sleep 2
end