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

When(/^I am on results mobile page$/) do
  find_by_id "productresults"
end

When(/^I use this link form old site to access mobile site "([^"]*)"$/) do |arg|
  visit '/m' + arg
end

And(/^These filters are present on mobile page "(.*)"$/) do |arg|
  brands = arg.split "-"
  brands.map!{ |x| x.strip }
  find_by_id('showFilterOptions').click

  lis = find_by_id('brandList').all('li')
  clean = lis.select{ |x| x['class'] != "more-brands" && x['class'] != "hide"}
  filters = clean.select{|x| x.first('input').selected? == true }.collect(&:text)
  filters.map!{ |x|  delete_last_word x}
  filters.each { |x| brands.include?(x).should == true }
end
