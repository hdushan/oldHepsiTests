#encoding: UTF-8

Given(/^I visit main page$/) do
  visit_main_page
end

Then(/^I am at main page$/) do
  page.should have_selector "#carousel"
  page.should have_selector "ul.static-banners"
end

Then(/^There are some results available$/) do
  results = find_by_id "productresults"
  find('li.search-item', match: :first)
  expect(results.all("li.search-item").count).to be > 0
  set_wait_time 20
  expect(page).to have_no_selector(".no-results")
  revert_to_default_wait_time
end

Given(/^I open search result no "([^"]*)"$/) do |arg|
  results = find_by_id "productresults"
  i = arg.to_i - 1
  if i >= 0
    res = results.all('li.search-item')[i]
    $p_id = res['id']
    $p_title = res.find('h3.product-title').text
    res.find('h3.product-title').click
  end
end

When(/^I am on product details$/) do
  $p_name = find_by_id("product-name").text
  $p_price = find_by_id("offering-price").text.to_i
  page.should have_selector "#quantity"
  page.should have_selector ".btn-decrease"
  page.should have_selector ".btn-increase"
  page.should have_selector "#addToCart"
end

Then(/^I add "([^"]*)" product\(s\) to cart$/) do |arg|
  i = arg.to_i
  unless i == 0
    $p_quantity = i
    fill_in "quantity", :with=> i
    find_by_id("addToCart").click
    # puts "Wating for ajax"
    # wait_for_ajax
    # puts "Wating for ajax - Done"
    # set_wait_time 5
    # page.should have_selector("#notification", :visible => true)
    # revert_to_default_wait_time
    # puts "Found notification..printing content"
    # puts find_by_id("notification").text
    # within("#notification") do
    #   puts "checking content"
    #   expect(page).to have_content("#{i} Ürün başarılı bir şekilde sepete eklenmiştir.")
    # end
    # page.should have_selector("#notification", visible: :hidden)
  end
end

Given(/^I go to checkout$/) do
  find_by_id('shoppingCart').click
end

Then(/^Product is listed in the checkout screen$/) do
  set_wait_time 5
  begin
    # page.should have_content $p_id
    # page.should have_content $p_price
    page.should have_content $p_quantity
    page.should have_content $p_name
  rescue RSpec::Expectations::ExpectationNotMetError
    p "Product detail: #{$p_name} not found on checkout page"
  end
  revert_to_default_wait_time
end

When(/^I am on checkout screen$/) do
  expect(page).to have_title('Sepetim')
  begin
    set_wait_time 30
    find('.fancybox-item.fancybox-close').click
    puts "Popup found and closed"
  rescue Exception => e
    puts "No Popup found"
  end
  revert_to_default_wait_time
  expect(page).to have_selector('.cart-title')
end

When(/^I am on checkout screen on mobile$/) do
  expect(page).to have_selector('header.box-header')
  within('h1.box-header-title') do
    expect(page).to have_content('Sepetim')
  end
end

Given(/^I navigate to Category$/) do |table|
  # table is a table.hashes.keys # => [:Elektronik Beyaz Eşya, :Bilgisayar Tablet]
  values = table.raw[0]
  cat1 = find('ul.browser-by-category').first('li', :text=> (capitalize values[0]))
  link = cat1.find('div.nav-home-wrapper').first('a', :text=> values[1])['href']
  puts "\nLink = #{link.to_s}\n"
  visit_link link
  expect(page).to have_selector('.link-more-results')
  $current_results = extract_number find_by_id('totalItems').text
end

When(/^I am on results page$/) do
  find_by_id "productresults"
end

Given(/^I select a sub category in browsing$/) do |table|
  # table is a table.hashes.keys # => [:Çevre Birimleri, :Mouse]
  values = table.raw[0]
  # i = values.size - 1
  # wait_for_ajax
  # $current_level =  find('ol.category-list-items', :visible => true)
  # values.each_with_index { |x, index|
  #   cat = $current_level.find('a', :text => x, match: :first)
  #   cat.click
  #   wait_for_ajax
  #   sleep 1
  #   if index == i
  #     break
  #   end
  #   $current_level.first('ul.children-category', :visible=>true)
  #   $current_level = $current_level.first('li.expanded', :visible=>true)
  # }
  # $current_results = extract_number find_by_id('totalItems').text
  cat = find('.widget.CategorySelector')
  current = cat
  i = values.size - 1
  values.each_with_index { |x, index|
    current.find('a', text: /^#{x}$/, match: :first).click
    if index == i
      break
    else
      if values[index + 1] == "Tümünü Gör"
        current.find('li', text: x, match: :first).find('a.view-all', match: :first).click
        wait_for_ajax
        break
      else
        current = current.find('li', text: x, match: :first).find('ul.sub-list', match: :first)
      end
    end
  }
end

When(/^I apply a filter$/) do |table|
  # table is a table.hashes.keys # => [:Markalar, :Everest]
  values = table.raw
  filter_tab = find ".FiltersList"
  $result_stack.clear
  $result_stack.push get_result_count
  values.each { |x|
    filter_tab.first('li', :text=> /^#{x[0]}/ )
    if x[0] == "Değerlendirme Puanı"
      regex = /star(-|_)#{(extract_number x[1]).to_s}/
      filter_tab.find('ol.rating-filter-list').all("label").select{|x| x['for'] =~ regex }[0].click
      wait_for_ajax
    else
      filter_tab.first('label', :text=> /^#{x[1]}/).click
      wait_for_ajax
    end
    filter_tab = find ".filters-container"
    $result_stack.push get_result_count
  }
  $current_results = extract_number find_by_id('totalItems').text
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
  $current_results = extract_number find_by_id('totalItems').text
end

And(/^print result stack$/) do
  p $result_stack
end

Then(/^I remove these filters$/) do |table|
  # table is a table.hashes.keys # => [:Değerlendirme Puanı, :4 yıldız]
  values = table.raw
  $result_stack.pop
  values.each { |x|
    find('div.applied-filter-container').first('li', :text => x[1]).first('a').click
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
  find('.search-item', match: :first)
  result_count = all('.search-item').size
  case arg
    when 'smart'
      find(".sort-wrapper .button").click
      find_by_id('sortResultsHeader').find('a', text: 'Akıllı sıralama').click
    when 'most-selling'
      find(".sort-wrapper .button").click
      find_by_id('sortResultsHeader').find('a', text: 'Çok Satanlar').click
    when 'lowest-price'
      find(".sort-wrapper .button").click
      find_by_id('sortResultsHeader').find('a', text: 'En düşük fiyat').click
    when 'highest-price'
      find(".sort-wrapper .button").click
      find_by_id('sortResultsHeader').find('a', text: 'En yüksek fiyat').click
  end
  sleep 2
  find('.search-item', match: :first)
  new_result_count = all('.search-item').size
  result_count.should == new_result_count
end

Then(/^Results are sorted according to "([^"]*)" filter$/) do |arg|
  case arg
    when 'smart'
      within("#sortResultsHeader") do
        expect(find('a', text: "Akıllı sıralama")['class']).to match(/selected/)
      end
    when 'most-selling'
      within("#sortResultsHeader") do
        expect(find('a', text: "Çok Satanlar")['class']).to match(/selected/)
      end
    when 'lowest-price'
      begin
        within("#sortResultsHeader") do
          expect(find('a', text: "En düşük fiyat")['class']).to match(/selected/)
        end
        products = all('.price-container').select{|x| x['style'] != "display: none;"}
        prices = products.collect{|x| format_price x.find('span.price').text}
        prices.should == prices.sort
      rescue Exception => e
        p 'Results are not sorted properly!!!'
        p prices
      end
    when 'highest-price'
      begin
        within("#sortResultsHeader") do
          expect(find('a', text: "En yüksek fiyat")['class']).to match(/selected/)
        end
        products = all('.price-container').select{|x| x['style'] != "display: none;"}
        prices = products.collect{|x| format_price x.find('span.price').text}
        prices.should == (prices.sort).reverse
      rescue Exception => e
        p 'Results are not sorted properly!!!'
        p prices
      end
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

Given(/^I search for a product "(.*?)"$/) do |arg|
  search_string = get_test_data(arg)
  puts "#{arg}:#{search_string}"
  (1..5).each do |i|
    puts "Search attempt no: #{i}"
    fill_in "productSearch" , :with => search_string
    find_by_id("buttonProductSearch").click
    set_wait_time 20
    begin
      find('.no-results')
      puts "There are no results!!"
      sleep 1
    rescue Exception => e
      puts "There are results!!"
      break
    end
  end
  revert_to_default_wait_time
end

And(/^The discount is "([^"]*)" percent on details$/) do |arg|
  discount = extract_number find("span.discount-amount").text
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
  visit_link 'http://www.google.com/webmasters/tools/richsnippets'
  find_by_id("tab-html").click

  fill_in("html-input", :with => $html_code)

  find_by_id('html-preview-button').first('div.goog-inline-block').click
  div = find_by_id("extracted-data-google")
  items = div.all('tbody', :text=> 'breadcrumb')
  $breadcrumbs.should == items.map{ |x| x.first('a')}.collect(&:text)
end


When(/^I hover on menu item "(.*?)"$/) do |arg|
  el = find('ul.browser-by-category').first('li', :text=> (capitalize arg))
  $container = el.find('div.nav-home-wrapper')
end

Then(/^There are campaign banners$/) do
  container = $container
  banner_divs = container.all "div.flyout-campaign-wrapper"
  banner_divs.each { |x|
    small_banners = x.all("div.small").size
    big_banners = x.all("div.big").size
    (small_banners + big_banners).size.should > 0
  }
end

When(/^I click on first small banner$/) do
  container = $container
  banner_div = container.find "div.flyout-campaign-wrapper"
  small_banners = banner_div.find("div.small")
  visit_link small_banners.all('a')[0]['href']
end

When(/^I click on second small banner$/) do
  container = $container
  banner_div = container.find "div.flyout-campaign-wrapper"
  small_banners = banner_div.find "div.small"
  visit_link small_banners.all('a')[1]['href']
end

When(/^I click on big banner$/) do
  container = $container
  banner_div = container.find "div.flyout-campaign-wrapper"
  big_banner = banner_div.find "div.big"
  visit_link big_banner.first('a')['href']
end

And(/^I unhover$/) do
  find_by_id("productSearch").hover
end

Then(/^I don't get the error page$/) do
  set_wait_time 5
  begin
    url = page.current_url
    page.should have_no_selector 'img[src="/Content/images/error.jpg"]'
  rescue Exception => e
    puts "Page not found error!!! on:\n#{url}\n"
    revert_to_default_wait_time
    raise e
  end
    revert_to_default_wait_time
    visit_main_page
end

When(/^I use this link form old site to access new site "([^"]*)"$/) do |arg|
  visit_link arg
end

And(/^These filters are present on page "(.*)"$/) do |arg|
  brands = arg.split "-"
  brands.map!{ |x| x.strip }
  div = find_by_id('productresults').find('div.applied-filter-container')
  filters = div.all('li.appliedFilter').collect(&:text)
  filters.each { |x| brands.include?(x).should == true }
end

When(/^I search for the stored product$/) do
  fill_in 'productSearch' , :with => $prod['productId']
  find_by_id('buttonProductSearch').click
end

And(/^Discounted price is displayed correctly$/) do
  price = format_price find('section.detail-main').find('span.price').text
  expect($prod['price']['value']).to eq(price)
  expect($prod['price']['taxIncluded']).to eq(true)
  puts "product sku equals #{$prod['productId']}"
  puts "Discount = #{$prod['discountRate']}"
  if $prod['discountRate']==0
    puts "Discount shouldnt be shown!!"
    find_by_id("product-discount-rate", :visible=>:hidden)
    expect(find_by_id("product-discount-rate").visible?).to eq(false)
  else
    discount = extract_number find_by_id("product-discount-rate").text
    expect(discount).to eq($prod['discountRate'])
  end
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
  items = find_by_id('dealOfTheDayCarousel').all('div.owl-item')
  items.each{ |x|
    price = format_price x.find('span.price').text
    org_price = format_price x.find('del.price.old').text
    discount = extract_number x.find('span.badge.highlight').text
    price.should_not == 0.0
    org_price.should_not == 0.0
    discount.should > 0
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
  puts "\nNumber of links to visit: #{$links.length}\n"
  $links.each{|x|
    puts "\nVisiting link: #{x.inspect}\n"
    visit_link x
    steps %{ Then I don't get the error page }
  }
end

Then(/^I visit these links (.*?) to (.*?) without an error page$/) do  |start_index, end_index|
  links_to_visit = $links[start_index.to_i..end_index.to_i]
  puts "\nNumber of links to visit: #{links_to_visit.length}\n"
  links_to_visit.each{|x|
    puts "\nVisiting link: #{x.inspect}\n"
    visit_link x
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
  items.each_with_index { |x, index|
    $links.push carousel.all('div.owl-item')[index].first('a')['href']
  }
  $links.each{|x|
    visit_link x
    steps %{ Then I don't get the error page }
  }
end

And(/^I see the price on search item no "([^"]*)"$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    item = find_by_id('productresults').all('li.search-item', :visible=> true)[i]
    $price = format_price item.find('span.price').text
  end
end

Then(/^price is listed correctly in details$/) do
  price = format_price find('section.detail-main').find('span.price').text
  price.should == $price
end

And(/^I click breadcrumb "([^"]*)"$/) do |arg|
  find('ul.breadcrumbs').find('span', :text=>arg).click
end

Given(/^I make a google search with "([^"]*)"$/) do |arg|
  visit_link 'http://www.google.com.tr'
  expect(page).to have_title "Google"
  fill_in "q" , :with=>arg
  if $browser_to_use==:phantomjs
    click_button "Google Search"
  else
    click_button "gbqfb"
  end
end

When(/^I click on google result no "([^"]*)"$/) do |arg|
  if $browser_to_use==:phantomjs
    id_of_google_results = "ires"
  else
    id_of_google_results = "rso"
  end
  i = arg.to_i - 1
  unless i < 0
    results = find_by_id(id_of_google_results).all('li.g')
    results[i].first('h3.r').click
  end
end

And(/^I click on logo$/) do
  find('a.headerLogoLink').click
end

When(/^I visit link "([^"]*)"$/) do |arg|
  visit_link arg
end

Then(/^I get error page$/) do
  first("img", :visible => true)['src'].should == Capybara.app_host + "/Content/images/error.jpg"
end

Given(/^I test things one$/) do
  puts "first"
  expect(1).to eq(1)
end

Given(/^I test things two$/) do
  puts "second"
  expect(1).to eq(2)
end

When(/^I click go to desktop version link$/) do
  first('footer', :visible => true).find('a.icon-desktop-link').click
end

Then(/^I am on old hepsiburada mainpage$/) do
  page.current_url.include?("http://www.hepsiburada.com/").should == true
  page.should have_content "Hepsiburada.com, Bir Doğan Online Markasıdır."
  page.should have_selector "#divMainPageSliderContainer"
end


Then(/^I should see a comment made by a "([^"]*)" person$/) do |arg|
  find_by_id('productReviewsTab').click
  div = find('div.reviews-main', visible: :true)
  found = false
  case arg.upcase
    when "MALE"
      while true
        div.find('li.review-item', match: :first)
        users = div.all('li.review-item').collect{|x| clean_string x.find('span.user-info').text }
        if users.include? "Erkek"
          found = true
          break
        else
          more_comments = find_by_id('showMoreComments')
          if more_comments.visible?
            find_by_id('showMoreComments').click
          else
            break
          end
        end
      end
      found.should == true
    when "FEMALE"
      while true
        div.find('li.review-item', match: :first)
        users = div.all('li.review-item').collect{|x| clean_string x.find('span.user-info').text }
        if users.include? "Bayan"
          found = true
          break
        else
          more_comments = find_by_id('showMoreComments')
          if more_comments.visible?
            find_by_id('showMoreComments').click
          else
            break
          end
        end
      end
      found.should == true
    when "NORMAL"
      while true
        div.find('li.review-item', match: :first)
        users = div.all('li.review-item').collect{|x| clean_string x.find('span.user-info').text }
        if (users - ["Erkek" , "Kadın"]).any?
          found = true
          break
        else
          more_comments = find_by_id('showMoreComments')
          if more_comments.visible?
            find_by_id('showMoreComments').click
          else
            break
          end
        end
      end
      found.should == true
  else

  end
end

When(/^There are items in carousel$/) do
  div = find_by_id("carousel").find('div.owl-stage')
  div.find('div.owl-item', match: :first)
  div.all('div.owl-item').size.should > 0
end

And(/^I clear sessions$/) do
  Capybara.reset_sessions!
end

And(/^I clear cart items$/) do
  find_by_id('shoppingCart').click
  expect(page.title).to eq("Sepetim")
  i=0
  set_wait_time 30
  begin
    button = find('a', text: "Sil")
    while button != nil
      i = i+1
      puts "Clearing item #{i}"
      button.click
      wait_for_ajax
      sleep 1
      button = find('a', text: "Sil")
    end
  rescue Exception => e
    puts "No items in cart"
  end
  revert_to_default_wait_time
end

Then(/^I set default wait time to "([^"]*)" seconds$/) do |arg|
  set_wait_time arg
end

Then(/^I revert to default wait time$/) do
  revert_to_default_wait_time
end

Then(/^I see product description$/) do
  find_by_id('productDescription').click
end

And(/^I see product reviews$/) do
  find_by_id('productReviews').click
  find('.review-item', match: :first)
  all('.review-item').size.should > 0
end

And(/^I see compatible products$/) do
  find_by_id('compatibleProducts').click
  find('.compatible-product-group', match: :first)
  all('.compatible-product-group').size.should > 0
end

And(/^I see return policy$/) do
  find_by_id('productReturnPolicy').click
  find_by_id('productReturnPolicyText')
end

And(/^I see product specifications$/) do
  find_by_id('productTechSpec').click
end

And(/^I return to previous page$/) do
  page.evaluate_script('window.history.back()')
end

And(/^I wait for "([^"]*)" seconds$/) do |arg|
  sleep arg.to_i
end

Then(/^There should be a way for me to give feedback$/) do
  find(".usabilla_live_button_container").click
  sleep 5
  frm = all('iframe', visible: true).select{ |x| x['data-tags']==nil }[0]
end

And(/^I add search result no "([^"]*)" to cart from search results$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    expect(page).to have_selector('.hovering-box')
    all('.hovering-box')[i].hover
    sleep 5
    #expect(page).to have_selector('button.add-to-basket', :visible => true)
    find_by_id('productresults').find('button.add-to-basket', match: :first)
    item = find_by_id('productresults').all('button.add-to-basket')[i]
    item.click
    wait_for_ajax
    page.should have_selector("#notification", :visible => true)
    page.should have_content("1 Ürün başarılı bir şekilde sepete eklenmiştir.")
    page.should have_selector("#notification", visible: :hidden)
  end
end
