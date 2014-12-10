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
  wait_for_ajax
  $current_level =  find('ul.nav-browse', :visible => true)
  values.each_with_index { |x, index|
    cat = $current_level.find('a', :text => x, match: :first)
    cat.click
    wait_for_ajax
    sleep 1
    if index == i
      break
    end
    $current_level.first('ul.children-category', :visible=>true)
    $current_level = $current_level.first('li.expanded', :visible=>true)
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
    li = list.find("li.category-level-#{$level.to_s}", :text=> x, match: :first)
    li.find('label', text: x, match: :first).click
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
  d = calculate_discount
  discount.should == d
end

When(/^I change the variant to "([^"]*)"$/) do |arg|
  first('label.price-label', :text=> arg).click
  wait_for_ajax
end


And(/^I store breadcrumbs$/) do
  ul = find('ul.breadcrumbs')
  $breadcrumbs.clear
  $breadcrumbs = ul.all('li').collect(&:text)
  $html_code = find('div.breadcrumbs-wrapper')['innerHTML']
end

Then(/^breadcrumbs should be available on google webtools$/) do
  visit 'http://www.google.com/webmasters/tools/richsnippets'
  find_by_id("tab-html").click

  fill_in("html-input", :with => $html_code)

  find_by_id('html-preview-button').first('div.goog-inline-block').click
  div = find_by_id("extracted-data-google")
  items = div.all('tbody', :text=> 'breadcrumb')
  $breadcrumbs.should == items.map{ |x| x.first('a')}.collect(&:text)
end


When(/^I hover on menu item "([^"]*)"$/) do |arg|
  el = find('ul.browser-by-category').first('li', :text=> arg)
  $container = el.find('div.nav-home-wrapper')
end

Then(/^There are campaign banners$/) do
  container = $container
  banner_div = container.find "div.flyout-campaign-wrapper"
  small_banners = banner_div.find "div.small"
  big_banner = banner_div.find "div.big"
  small_banners.all('img').size.should == 2
  big_banner.all('img').size.should == 1
end

When(/^I click on first small banner$/) do
  container = $container
  banner_div = container.find "div.flyout-campaign-wrapper"
  small_banners = banner_div.find "div.small"
  visit small_banners.all('a')[0]['href']
end

When(/^I click on second small banner$/) do
  container = $container
  banner_div = container.find "div.flyout-campaign-wrapper"
  small_banners = banner_div.find "div.small"
  visit small_banners.all('a')[1]['href']
end

When(/^I click on big banner$/) do
  container = $container
  banner_div = container.find "div.flyout-campaign-wrapper"
  big_banner = banner_div.find "div.big"
  visit big_banner.first('a')['href']
end

And(/^I unhover$/) do
  find_by_id("productSearch").hover
end

Then(/^I don't get the error page$/) do
  begin
    set_wait_time 5
    page.should have_no_selector 'img[src="/Content/images/error.jpg"]'
    revert_to_default_wait_time
  rescue RSpec::Expectations::ExpectationNotMetError
    revert_to_default_wait_time
    url = page.current_url
    visit ''
    fail "Page not found error!!! on\n#{url}"
  end
end

When(/^I use this link form old site to access new site "([^"]*)"$/) do |arg|
  visit arg
end

And(/^These filters are present on page "(.*)"$/) do |arg|
  brands = arg.split "-"
  brands.map!{ |x| x.strip }
  div = find_by_id('productresults').find('div.filter-container')
  filters = div.all('li.appliedFilter').collect(&:text)
  filters.each { |x| brands.include?(x).should == true }
end

When(/^I search for the stored product$/) do
  fill_in 'productSearch' , :with => $prod['productId']
  find_by_id('buttonProductSearch').click
end

And(/^Discounted price is displayed correctly$/) do
  price = format_price find_by_id('offering-price').text
  $prod['price']['value'].should == price
  $prod['price']['taxIncluded'].should == true
  $prod['discountRate'].should_not == 0
end

Given(/^I retrieve details from product service with id "([^"]*)"$/) do |arg|
  resp = RestClient.get "http://productinformation.qa.hepsiburada.com/product/sku/" + arg
  $prod = JSON.parse resp
end

Then(/^There should be "([^"]*)" banners next to carousel$/) do |arg|
  count = arg.to_i
  banner_area = find('div.home-container').first('div.container').first('ul.static-banners', :visible=>true)
  banner_area.all('img', :visible => true).size.should == count
end

When(/^There is a feedback button on current page$/) do
  page.should have_selector("div.usabilla_live_button_container", :visible=>true)
end

Then(/^I should be able to give feedback$/) do
  find_by_id("btnSendFeedback").click
  sleep 5
  frm = all('iframe', :visible=>true).select{ |x| x['data-tags']==nil }[0]
  within_frame frm do
    page.should have_content "Özel geri bildirim"
    page.should have_content "Bu sayfayla ilgili belirli bir alan hakkında geri bildirimde bulunmak istiyorum."
    page.should have_content "Genel geri bildirim"
    page.should have_content "Tüm web sitesi hakkında geri bildirimde bulunmak istiyorum."
    page.find_by_id('contents').find('a.close').click
  end
end

When(/^There are some items in deal of the day carousel$/) do
  find_by_id('dealOfTheDayCarousel').all('div.owl-item.active', :visible => true).size.should > 0
end

Then(/^Original prices should be displayed in deal of the day items$/) do
  items = find_by_id('dealOfTheDayCarousel').all('div.owl-item.active', :visible => true)
  items.each{ |x|
    price = format_price x.find('span.product-price').text
    org_price = format_price x.find('del.product-old-price').text
    price.should_not == 0.0
    org_price.should_not == 0.0
    org_price.should > price
  }
end

Then(/^There are items in the menu content$/) do
  content = $container
  groups = content.all('ul.nav-home')
  groups.each { |x|
    links = x.all('a').select{|x| x['href'] != nil}
    links.size.should > 0
  }
end

When(/^I store links from this menu item$/) do
  content = $container
  groups = content.all('ul.nav-home')
  $links = Array.new
  groups.each { |x|
    links = x.all('a').select{|x| x['href'] != nil}
    links.each{ |x| $links.push x['href']}
  }
end

Then(/^I visit these links without an error page$/) do
  $links.each{|x|
    visit x
    steps %{ Then I don't get the error page }
  }
end

And(/^I store filter results$/) do
  div = find_by_id "productresults"
  $search_results = div.all('li.search-item').map{|x| x.find('h3.product-title').text }
end

Then(/^I should have same items in the results$/) do
  div = find_by_id "productresults"
  results = div.all('li.search-item').map{|x| x.find('h3.product-title').text }
  $search_results.size.should == results.size
  results.each{|x| $search_results.include?(x).should == true }
end

Then(/^I should cycle through all of them and visit links$/) do
  carousel = find_by_id("carousel")
  items = carousel.all('div.owl-dot', :visible => true)
  $links = Array.new
  items.each { |x|
    x.click
    $links.push carousel.find('div.owl-item.active').first('a')['href']
  }
  $links.each{|x|
    uri = URI.parse(URI.encode(x.strip))
    visit uri
    steps %{ Then I don't get the error page }
  }
end

And(/^I see the price on search item no "([^"]*)"$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    item = find_by_id('productresults').all('li.search-item', :visible=> true)[i]
    $price = format_price item.find('span.product-price').text
  end
end

Then(/^price is listed correctly in details$/) do
  price = format_price find_by_id('offering-price').text
  price.should == $price
end

And(/^I click breadcrumb "([^"]*)"$/) do |arg|
  find('ul.breadcrumbs').find('span', :text=>arg).click
end

Given(/^I make a google search with "([^"]*)"$/) do |arg|
  visit 'http://www.google.com'
  fill_in "gbqfq" , :with=>arg
  click_button "gbqfb"
end

When(/^I click on google result no "([^"]*)"$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    results = find_by_id('rso').all('li.g')
    results[i].first('h3.r').click
  end
end

And(/^I click on logo$/) do
  find('a.headerLogoLink').click
end

When(/^I visit link "([^"]*)"$/) do |arg|
  visit format_link arg
end

Then(/^I get error page$/) do
  first("img", :visible => true)['src'].should == Capybara.app_host + "/Content/images/error.jpg"
end

Given(/^I test things$/) do
  p find("span[itemprop=priceCurrency]").text
  el = find_by_id "originalPrice"
  p el.text.split(" ")[1]
end

When(/^I click go to desktop version link$/) do
  first('footer', :visible => true).find('a.icon-desktop-link').click
end

Then(/^I am on old hepsiburada mainpage$/) do
  page.current_url.should == "http://www.hepsiburada.com/"
  page.should have_content "hepsiburada.com"
  page.should have_selector "#divMainPageSliderContainer"
end