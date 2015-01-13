#encoding: UTF-8

Given(/^I hover on menu item "([^"]*)" for warmup$/) do |arg|
  begin
    el = find('ul.browser-by-category').first('li', :text=> (capitalize arg))
    $container = el.find('div.nav-home-wrapper')
  rescue Exception => e
    p "something went wrong in warmup"
  end
end

When(/^I store links from this menu item on warmup$/) do
  begin
    content = $container
    groups = content.all('ul.nav-home')
    $links = Array.new
    groups.each { |x|
      links = x.all('a').select{|x| x['href'] != nil}
      links.each{ |x| $links.push x['href']}
    }
  rescue Exception => e
    p "something went wrong in warmup"
  end
end

Then(/^I visit these links on warmup$/) do
  begin
    $links.each{|x|
      visit_link x
      steps %{ Then I don't get the error page }
    }
  rescue Exception => e
    p "something went wrong in warmup"
  end
end

Given(/^I make a search for item "([^"]*)" on warmup$/) do |arg|
  begin
    fill_in 'productSearch', :with => arg
    page.find_by_id('buttonProductSearch').click
    if arg.strip != ""
      $current_results = extract_number find_by_id('totalItems').text
    end
  rescue Exception => e
    p "something went wrong in warmup"
  end
end

Then(/^I open search result no "([^"]*)" on warmup$/) do |arg|
  begin
    results = find_by_id "productresults"
    i = arg.to_i - 1
    if i >= 0 and i<RESULTS_PER_PAGE
      res = results.all('li.search-item')[i]
      $p_id = res['id']
      $p_title = res.find('h3.product-title').text
      res.find('h3.product-title').click
    end
  rescue Exception => e
    p "something went wrong in warmup"
  end
end

Given(/^I visit main page on warmup$/) do
  begin
    visit_main_page
  rescue Exception => e
    p "something went wrong in warmup"
  end
end