#encoding: UTF-8
Then(/^I should see "([^"]*)" global filter on main page$/) do |arg|
  if arg == "Bugün Teslimat"
    find_by_id('todays-delivery-filter')
  else
    find('.global-filters').find('span', text: arg, visible: :true)
  end
end

Then(/^I should see "([^"]*)" global filter on CLP$/) do |arg|
  if arg == "Bugün Teslimat"
    find_by_id('todays-delivery-filter')
  else
    find('.global-filters').find('a', text: arg, visible: :true)
  end
end

When(/^I apply global filter "([^"]*)" on "([^"]*)"$/) do |arg1, arg2|
  case arg2.upcase
    when 'CLP'
      find('.global-filters').find('a', text: arg1, visible: :true).click
    when 'HOMEPAGE'
      if arg1 == "Bugün Teslimat"
        find_by_id('todays-delivery-filter').click
      else
        find('.global-filters').find('a', text: arg1, visible: :true).click
      end
  end
end

And(/^I see "([^"]*)" global filter actively selected$/) do |arg|
  find('.global-filters').find('li', text: arg)['class'].should == 'active'
end

And(/^Page description contains "([^"]*)"$/) do |arg|
  find('head').find("meta[name='description']")['content'].should == arg
end

Then(/^I see this global filter order on mainpage$/) do |table|
  # table is a table.hashes.keys # => [:Kargo Bedavalar]
  values = table.raw
  filters = find('.global-filters').all('li')
  values.each_with_index { |x, index|
    if x[0] == "Bugün Teslimat"
      filters[index].find_by_id('todays-delivery-filter')
    else
      x[0].should == filters[index].text
    end
  }
end

Then(/^I see this global filter order on GFLP$/) do |table|
  # table is a table.hashes.keys # => [:Kargo Bedavalar]
  values = table.raw
  filters = find('.global-filters').all('li')
  values.each_with_index { |x, index| x[0].should == filters[index].text }
end

Then(/^I see this global filter order on CLP$/) do |table|
  # table is a table.hashes.keys # => [:Kargo Bedavalar]
  values = table.raw
  filters = find('.global-filters').all('li')
  values.each_with_index { |x, index| x[0].should == filters[index].text }
end
