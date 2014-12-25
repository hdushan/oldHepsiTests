#encoding: UTF-8
Then(/^I should see "([^"]*)" global filter on main page$/) do |arg|
  find('.global-filters').find('span', text: arg, visible: :true)
end

Then(/^I should see "([^"]*)" global filter on CLP$/) do |arg|
  find('.global-filters').find('a', text: arg, visible: :true)
end

When(/^I apply global filter "([^"]*)" on "([^"]*)"$/) do |arg1, arg2|
  case arg2.upcase
    when 'CLP'
      find('.global-filters').find('a', text: arg1, visible: :true).click
    when 'HOMEPAGE'
      find('.global-filters').find('span', text: arg1, visible: :true).click
  end
end

And(/^I see "([^"]*)" global filter actively selected$/) do |arg|
  find('.global-filters').find('li', text: arg)['class'].should == 'active'
end

And(/^Page description contains "([^"]*)"$/) do |arg|
  find('head').find("meta[name='description']")['content'].should == arg
end