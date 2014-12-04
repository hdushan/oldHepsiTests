#encoding: UTF-8

Given(/^I visit mobile main page$/) do
  visit "/m/"
end

Then(/^I am at mobile main page$/) do
  page.should have_selector "#productSearch"
end

Given(/^I navigate to Mobile_Category$/) do |table|
  # table is a table.hashes.keys # => [:Elektronik Beyaz Eşya, :Bilgisayar Tablet]
  values = table.raw[0]
  find('a.icon-hamburger').click
  values.each { |x|  x
  ul = find('ul.nav-home')
  ul.first('a', :text=> x).click
  }
end




