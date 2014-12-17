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
  ul.find('a', :text=> x, match: :first).click
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

When(/^I click the Hepsiburada logo$/) do
  find('a.logo-hepsiburada').click
end

Then(/^I should be redirected to mobile Homepage$/) do
  page.should have_selector "#productSearch"
  page.should have_selector "#dealOfTheDayCarousel"
end

And(/^I click on the checkout$/) do
  click_link 'shoppingCart'
end


Then(/^Clear button in filter should be disabled$/) do
  find_by_id('showFilterOptions').click
  button = find_by_id('btnClearFilters')
  button['disabled'].should == "true"
  find_by_id('showFilterOptions').click
end

And(/^I apply a filter on mobile$/) do |table|
  # table is a table.hashes.keys # => [:Markalar, :Philips]
  values = table.raw
  find_by_id('showFilterOptions').click
  filter_tab = find_by_id "filterResults"
  $result_stack.push get_result_count
  values.each { |x|
    filter_tab.first('li', :text=> /^#{x[0]}/ )
    if x[0] == "Değerlendirme Puanı"
      str = "star_" + (extract_number x[1]).to_s
      filter_tab.find("label[for='#{str}']").click
    else
      filter_tab.first('label', :text=> /^#{x[1]}/).click
    end
    filter_tab = find_by_id "filterResults"
    $result_stack.push get_result_count
  }
  find_by_id('btnApplyFilters').click
end

Then(/^Clear button in filter should be enabled$/) do
  find_by_id('showFilterOptions').click
  button = find_by_id('btnClearFilters')
  button['disabled'].should == nil
  find_by_id('showFilterOptions').click
end

And(/^I clear filters on mobile$/) do
  find_by_id('showFilterOptions').click
  find_by_id('btnClearFilters').click
end

And(/^Apply button in filter should be enabled$/) do
  find_by_id('showFilterOptions').click
  button = find_by_id('btnApplyFilters')
  button['disabled'].should == nil
  find_by_id('showFilterOptions').click
end

When(/^I remove filters on mobile$/) do |table|
  # table is a table.hashes.keys # => [:Markalar, :Twigy]
  values = table.raw
  find_by_id('showFilterOptions').click
  filter_tab = find_by_id "filterResults"
  $result_stack.push get_result_count
  values.each { |x|
    filter_tab.first('li', :text=> /^#{x[0]}/ )
    if x[0] == "Değerlendirme Puanı"
      li = find('li', text: x[0], match: :first)
      li.find('a.remove-filter').click
    else
      filter_tab.first('label', :text=> /^#{x[1]}/).click
    end
    filter_tab = find_by_id "filterResults"
    $result_stack.push get_result_count
  }
  find_by_id('btnApplyFilters').click
end


When(/^I uncheck filters on mobile$/) do |table|
  # table is a table.hashes.keys # => [:Markalar, :Victorinox]
  values = table.raw
  find_by_id('showFilterOptions').click
  filter_tab = find_by_id "filterResults"
  $result_stack.push get_result_count
  values.each { |x|
    filter_tab.first('li', :text=> /^#{x[0]}/ )
    if x[0] == "Değerlendirme Puanı"
      str = "star_" + (extract_number x[1]).to_s
      filter_tab.find("label[for='#{str}']").click
    else
      filter_tab.first('label', :text=> /^#{x[1]}/).click
    end
    filter_tab = find_by_id "filterResults"
    $result_stack.push get_result_count
  }
end

When(/^I click my account button on mobile$/) do
  find('a.icon-hamburger').click
  find('div.hamburger-content').find_by_id('myAccount').click
end

Then(/^I am on mobile login page$/) do
  find('div.login-container')
end