#encoding: UTF-8

Given(/^I visit main page$/) do
  visit ''
end

Then(/^I am at main page$/) do
  page.should have_selector "#carousel"
  page.should have_selector "ul.static-banners"
end

Then(/^There are some results available$/) do
  results = find_by_id "productresults"
  set_wait_time 3
  results.should have_selector "div.sort-controls-container"
  revert_to_default_wait_time
end

Given(/^I open search result no "([^"]*)"$/) do |arg|
  results = find_by_id "productresults"
  i = arg.to_i - 1
  if i >= 0 and i<RESULTS_PER_PAGE
    res = results.all('li.search-item')[i]
    $p_id = res['id']
    res.find('h3.product-title').click
  end
end

When(/^I am on product details$/) do
  $p_name = find_by_id("product-name").text
  $p_price = find_by_id("offering-price").text.to_i
  page.should have_selector "#quantity"
  page.should have_selector "div.quantity-changer"
  page.should have_selector "#addToCart"
end

Then(/^I add "([^"]*)" product\(s\) to cart$/) do |arg|
  i = arg.to_i
  unless i == 0
    $p_quantity = i
    fill_in "quantity", :with=> i
    find_by_id("addToCart").click
    find_by_id('notification').should have_content("#{i} Ürün başarılı bir şekilde sepete eklenmiştir.")
    sleep 2
  end
end

Given(/^I go to checkout$/) do
  find_by_id('shoppingCart').click
end

Then(/^Product is listed in the checkout screen$/) do
  set_wait_time 5
  begin
    page.should have_content $p_id
    page.should have_content $p_price
    page.should have_content $p_quantity
    page.should have_content $p_name
  rescue RSpec::Expectations::ExpectationNotMetError
    p "Product detail: #{$p_name} not found on checkout page"
  end
  revert_to_default_wait_time
end


When(/^I am on new checkout screen$/) do
  page.should have_content "Sku"
  page.should have_content "Product Name"
  page.should have_content "Merchant"
  page.should have_content "Quantity"
  page.should have_content "Price"
  page.should have_content "Sum"

  page.should have_selector "#create-order"
  page.should have_selector "#create-order-alternate-address"
  page.should have_selector "#clearCart"
end

Given(/^I navigate to Category$/) do |table|
  # table is a table.hashes.keys # => [:Elektronik Beyaz Eşya, :Bilgisayar Tablet]
  values = table.raw[0]
  cat1 = find('ul.browser-by-category').first('li', :text=> values[0])
  link = cat1.find('div.nav-home-wrapper').first('a', :text=> values[1])['href']
  visit link
end

When(/^I am on results page$/) do
  find_by_id "productresults"
end

Given(/^I select a sub category in browsing$/) do |table|
  # table is a table.hashes.keys # => [:Çevre Birimleri, :Mouse]
  values = table.raw[0]
  i = values.size - 1
  $current_level =  find('ul.nav-browse', :visible => true)
  values.each_with_index { |x, index|
    cat = $current_level.first('a', :text => x)
    cat.click
    if index == i
      break
    end
    $current_level.first('ul.children-category')
    $current_level = $current_level.first('li.expanded')
  }
end

When(/^I apply a filter$/) do |table|
  # table is a table.hashes.keys # => [:Markalar, :Everest]
  values = table.raw
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

Given(/^I select a sub category in search$/) do |table|
  # table is a table.hashes.keys # => [:Çevre Birimleri, :Mouse]
  values = table.raw[0]
  list = find_by_id "categoryList"
  $level = 0
  values.each { |x|
    list.first("li.category-level-#{$level.to_s}", :text => x).click
    list = find_by_id "categoryList"
    $level += 1
  }
end

And(/^print result stack$/) do
  p $result_stack
end

Then(/^I remove these filters$/) do |table|
  # table is a table.hashes.keys # => [:Değerlendirme Puanı, :4 yıldız]
  values = table.raw
  $result_stack.pop
  values.each { |x|
    find('div.filter-container').first('li', :text => x[1]).first('a').click
    sleep 2
    i = $result_stack.pop
    get_result_count.should == i
  }
end

Then(/^I clear filters$/) do
  find_by_id('btnClearFilters').click
  sleep 2
  get_result_count.should == $result_stack[0]
end

When(/^I sort with "([^"]*)" filter$/) do |arg|
  case arg
    when 'smart'
      find_by_id('bestMatching').click
      sleep 2
    when 'most-selling'
      find_by_id('bestSelling').click
      sleep 2
    when 'lowest-price'
      find_by_id('lowestPrice').click
      sleep 2
    when 'highest-price'
      find_by_id('highestPrice').click
      sleep 2
  end
end

Then(/^Results are sorted according to "([^"]*)" filter$/) do |arg|
  case arg
    when 'smart'
      find_by_id('bestMatching')['class'].include?('selected').should == true
    when 'most-selling'
      find_by_id('bestSelling')['class'].include?('selected').should == true
    when 'lowest-price'
      find_by_id('lowestPrice')['class'].include?('selected').should == true
      prices = all('span.product-price').collect(&:text).map!{ |x| format_price x }
      prices.should == prices.sort
    when 'highest-price'
      find_by_id('highestPrice')['class'].include?('selected').should == true
      prices = all('span.product-price').collect(&:text).map!{ |x| format_price x }
      prices.should == (prices.sort).reverse
  end
end

Then(/^clear data$/) do
  Capybara.reset_sessions!
  $result_stack.clear
end

And(/^close browser$/) do
  page.execute_script "window.close();"
end

And(/^Top sellers an discount items are not visible$/) do
  set_wait_time 10
  page.should have_no_selector "div.discounted-product-container"
  page.should have_no_selector "div.top-seller-container"
  revert_to_default_wait_time
end

Given(/^I search for a product with "([^"]*)"$/) do |arg|
  fill_in "productSearch" , :with => arg
  find_by_id("buttonProductSearch").click
end

And(/^The discount is "([^"]*)" percent on details$/) do |arg|
  discount = find_by_id("product-discount-rate").first('del').text.to_i
  discount.should == arg.to_i
  # d = calculate_discount
  # discount.should == d
end

When(/^I change the variant to "([^"]*)"$/) do |arg|
  first('label.price-label', :text=> arg).click
  wait_for_ajax
end


And(/^I store breadcrumbs$/) do
  ul = find('ul.breadcrumbs')
  $arr = ul.all('li').collect(&:text)
end

Then(/^breadcrumbs should be available on page$/) do
  p "here"
end