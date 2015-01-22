#encoding: UTF-8

Given(/^I visit mobile main page$/) do
  visit_link "/m/"
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
  visit_link '/m' + arg
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
    filter_tab.find('button', :text=> /^#{x[0]}$/).click
    if x[0] == "Değerlendirme Puanı"
      str = "star_" + (extract_number x[1]).to_s
      filter_tab.find("label[for='#{str}']").click
    else
      filter_tab.first('label', :text=> /^#{x[1]}/).click
    end
    filter_tab.find('button', :text=> /^#{x[0]}$/).click
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
    filter_tab.find('button', :text=> /^#{x[0]}$/).click
    if x[0] == "Değerlendirme Puanı"
      li = find('li', text: x[0], match: :first)
      li.find('a.remove-filter').click
    else
      filter_tab.first('label', :text=> /^#{x[1]}/).click
    end
    filter_tab = find_by_id "filterResults"
    $result_stack.push get_result_count
    filter_tab.find('button', :text=> /^#{x[0]}$/).click
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

And(/^I should see indicators for "([^"]*)"$/) do |arg|
  case arg
    when "Kargo Bedavalar"
      find_by_id('productresults').find('.search-item', match: :first)
      items = find_by_id('productresults').all(".search-item")
      items.each { |x|
        x.should have_content "Kargo Bedava"
      }
    when "Süper Hızlı Gönderiler"
      find_by_id('productresults').find('.search-item', match: :first)
      items = find_by_id('productresults').all(".search-item")
      items.each { |x|
        x.should have_content "Süper Hızlı"
      }
    when "İndirimli Ürünler"
      find_by_id('productresults').find('.search-item', match: :first)
      items = find_by_id('productresults').all(".search-item")
      items.each { |x|
        x.should have_selector ".discount-badge"
      }
    else

  end
end

And(/^I am still on mobile page$/) do
  page.current_url.include?("storefront.qa.hepsiburada.com/m/")
end

Then(/^There is a top sellers section in mobile$/) do
  sect = find('.top-seller')
  sect.find('li.search-item', match: :first)
  sect.all('li.search-item').size.should > 0
end

And(/^There is a recommended products section in mobile$/) do
  div = find("div.ProductList", text: "İlginizi Çekebilecek Ürünler")
  div.all(".search-item").size.should <=10
end

And(/^I see related search keywords on search result page$/) do |table|
  # table is a table.hashes.keys # => [:bebek bezi, :bebek arabası, :bebek beşikleri]
  keywords = find_by_id("relatedKeywords")
  values = table.raw[0]
  values.each { |x| keywords.should have_content x}
  end


And(/^I see related search categories on search result page$/) do |table|
  # table is a table.hashes.keys # => [:Süpermarket / Bebek Bezleri ve Alt Açma]
  categories = find_by_id("relatedCategories")
  values = table.raw[0]
  values.each { |x| categories.should have_content x}
end

When(/^I sort with "([^"]*)" filter on mobile$/) do |arg|
  case arg
    when 'smart'
      find_by_id('showSortOptions').click
      find_by_id('bestMatching').click
      sleep 2
      wait_for_ajax
    when 'most-selling'
      find_by_id('showSortOptions').click
      find_by_id('bestSelling').click
      sleep 2
      wait_for_ajax
    when 'lowest-price'
      find_by_id('showSortOptions').click
      find_by_id('lowestPrice').click
      sleep 2
      wait_for_ajax
    when 'highest-price'
      find_by_id('showSortOptions').click
      find_by_id('highestPrice').click
      sleep 2
      wait_for_ajax
  end
end

Then(/^Results are sorted according to "([^"]*)" filter on mobile$/) do |arg|
  case arg
    when 'smart'
      find_by_id('showSortOptions').click
      find_by_id('bestMatching')['class'].include?('selected').should == true
      find_by_id('showSortOptions').click
    when 'most-selling'
      find_by_id('showSortOptions').click
      find_by_id('bestSelling')['class'].include?('selected').should == true
      find_by_id('showSortOptions').click
    when 'lowest-price'
      find_by_id('showSortOptions').click
      find_by_id('lowestPrice')['class'].include?('selected').should == true
      find_by_id('showSortOptions').click
      products = all('.product-price-wrapper')
      prices = products.collect{|x| format_price x.find('.product-price').text}
      prices.should == prices.sort
    when 'highest-price'
      find_by_id('showSortOptions').click
      find_by_id('highestPrice')['class'].include?('selected').should == true
      find_by_id('showSortOptions').click
      products = all('.product-price-wrapper')
      prices = products.collect{|x| format_price x.find('.product-price').text}
      prices.should == (prices.sort).reverse
  end
end

Then(/^I select a sub category in mobile$/) do |table|
  # table is a table.hashes.keys # => [:Fotoğraf Makinesi ve Kamera, :Tümünü Gör]
  values = table.raw[0]
  i = values.size - 1
  wait_for_ajax
  $current_level =  find('ol.category-list-items', :visible => true)
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
  $current_results = extract_number find_by_id('totalItems').text
end
