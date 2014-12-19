#encoding: UTF-8
Given /^I select a product from search results$/ do
  # product_links = all(:xpath, "//li[@class = 'search-item'][.//@class = 'product-price']")
  # product = product_links[rand(product_links.length)]
  # @product_image = product.first('.product-image-wrapper img')['src'].split('/').last
  # @product_name = product.first('.product-title').text
  # click_link(@product_name)
  search_item = find_by_id('productresults').first('.search-item')
  @product_name = search_item.first('.product-title').text
  #@product_image = search_item.first('.product-image-wrapper img')['src'].split('/').last
  click_link(@product_name)
end

When(/^I click the 'add to basket' button on results page$/) do
  find('button.add-to-basket', match: :first).click
end

Then(/^I should see a list of (.*) results$/) do | search_term |
  @total_items = page.find_by_id('totalItems').text
  expect(first('.search-item a')).to have_content search_term
end

Then(/^I should see no results page$/) do
  expect(find(".no-results-container"))
  page.should have_content "Üzgünüz, aramanızla eşleşen ürün bulunamadı. Lütfen ürünün adını doğru girdiğinizden emin olunuz. Ana sayfaya dönebilirsiniz ve kategoriler aracılığıyla ürünlere göz gezdirebilirsiniz."
end

Then(/^I should see (.*) visible results$/) do | amount_of_visible_results |
  sleep(2)
  expect(all(".search-item").count.to_s).to eq amount_of_visible_results
end

Then(/^I see either a price or an unavailable statement for each result$/) do
  expect(all('.price-container').count + all('.procurement-status').count).to eq all('.search-item').count
end

Then(/^I see a product image for each result$/) do
  expect(all('.product-image').count).to eq all('.search-item').count
end

Then(/^I see ratings for all products$/) do
  expect(all('.search-item .product-rating').count).to eq all('.search-item').count
end

Then(/^I do not see a breadcrumb trail$/) do
  set_wait_time 3
  expect(page).not_to have_selector('.breadcrumbs-wrapper')
  revert_to_default_wait_time
end

When /^I click on a product from the search results$/ do
  page.all('.product-image').first.click
end

Then /^I should see a breadcrumb trail$/ do
  page.should have_selector('.breadcrumbs-wrapper')
  find('div.breadcrumbs-wrapper').all('li[itemtype="http://data-vocabulary.org/Breadcrumb"]').size.should > 0
end

Then /^I should see the variants message for the product$/ do
  page.should have_selector('.product-with-variant')
end

Then /^I should not see the variants message for the product$/ do
  page.should_not have_selector('.product-with-variant')
end

Then /^I should see the discount badge$/ do
  page.should have_selector('.discount-badge')
end

Then /^I should not see the discount badge$/ do
  set_wait_time 5
  page.should_not have_selector('.discount-badge')
  revert_to_default_wait_time
end

Then /^I see an indicator of free shipping associated with the item$/ do
  find_by_id('productresults', :visible => true).should have_content("Kargo Bedava")
end

When /^I choose the category (.*)$/ do | category |
  page.find_by_id('categoryList').find('label', :text=> category).click
end

Then /^the results are updated to reflect items in the category$/ do
  updated_total_items = page.find_by_id('totalItems').text  
  expect(updated_total_items).should_not eq(@total_items)
end 

And /^I see one or more second level categories$/ do
  page.all('.category-level-1').count.should > 1
end
	
And /^the category level (\d+) has the number of items$/ do | category_level |
  page.all('.category-level-' + category_level).each do | category | 
     expect(category.find(:css, 'label span').text).should_not eq('')
  end
end

And /^I can return to the first level category (.*)$/ do | category |  
  page.find('.category-level-0').find('label', :text=> category).click
end

Then /^I see an area for filtering by category$/ do
  page.should have_selector('.filters-container')
end

When(/^I search for an item "(.*?)".*$/) do  |item|
  steps %{When I search for "#{item}"}
end

Then(/^I see an indicator of fast delivery associated with the item$/) do
  page.find('.shipping-status').should have_content("Süper Hızlı")
end

Then(/^I should see (\d+) related search keywords for "(.*?)"$/) do |num_expected_keywords, search_term|
  related_keywords = page.find_by_id('relatedKeywords').all('a')
  expect(related_keywords.size).to eq(num_expected_keywords.to_i)
  related_keywords.each do |related_keyword|
    expect(related_keyword.text.downcase).to include(search_term.downcase)
  end
end

And(/^I should see (\d+) related search categories for "([^"]*)"$/) do |num_expected_categories, search_term|
  related_categories = page.find_by_id('relatedCategories').all('a')
  expect(related_categories.size).to eq(num_expected_categories.to_i)
  related_categories.each do |related_category|
    expect(related_category.text.downcase).to include(search_term.downcase)
  end
end

And(/^On clicking a related keyword "(.*?)"$/) do |related_keyword|
  page.find_by_id('relatedKeywords').find('a', :text=>related_keyword).click
end

Then(/^I should see search results of that keyword "(.*?)"$/) do |related_keyword|
  expect(page.find_by_id('productSearch').value.downcase).to eq(related_keyword.downcase)
end

And(/^On clicking a related category "(.*?)"$/) do |related_category|
  page.find_by_id('relatedCategories').find('a', :text=>related_category).click
end

Then(/^I should see search results with each result having the word "(.*?)" in the product name$/) do |keyword|
  results = page.find_by_id('productresults').all('li.search-item').map{|x| x.find('h3.product-title').text.downcase }
  results.each{|x| expect(x).to include(keyword.downcase) }
end

Then(/^Add to cart button is not available on result no "([^"]*)"$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    res = find_by_id('productresults')
    res.find('li.search-item', match: :first)
    item = res.all('li.search-item')[i]
    item.should have_content "Bu ürün geçici olarak temin edilememektedir."
    item.should have_no_selector "button.add-to-basket"
  end
end

Then(/^There are more than "([^"]*)" results$/) do |arg|
  i = extract_number find_by_id('totalItems').text
  i.should > arg.to_i
end

Then(/^There are "([^"]*)" results displayed$/) do |arg|
  res = find_by_id('productresults')
  res.find('li.search-item', match: :first)
  items = res.all('li.search-item')
  items.size.should == arg.to_i
end

When(/^There are "([^"]*)" brands in brand filter$/) do |arg|
  i = arg.to_i
  list = find_by_id('brandList')
  list.find('label', visible: :true, match: :first)
  list.all('li').select{|x| x['class'] != "hide" && x['class'] != "more-brands"}.size.should == i
end

And(/^There is more brands button$/) do
  find_by_id('moreBrandsInFilters')
end

Then(/^I press more brands button$/) do
  find_by_id('moreBrandsInFilters').click
end

And(/^There are more than "([^"]*)" brands in the filter area$/) do |arg|
  i = arg.to_i
  list = find_by_id('brandList')
  list['class'].include?("show-all-brands").should == false
  list.find('label', visible: :true, match: :first)
  list.all('label', visible: :true).size.should > i
end

And(/^I store search result count$/) do
  $search_result_count = extract_number find_by_id('totalItems').text
end

And(/^I store filtered search result count$/) do
  $filtered_result_count = extract_number find_by_id('totalItems').text
end

Then(/^Current search results count should be same as the first one$/) do
  i = extract_number find_by_id('totalItems').text
  i.should == $search_result_count
end

Then(/^Current filtered results count should be same as the first one$/) do
  i = extract_number find_by_id('totalItems').text
  i.should == $filtered_result_count
end

Then(/^Sub categories are displayed in filters section$/) do
  list = find_by_id('categoryList')
  list.find('li.category-level-0', match: :first)
  list.all('li.category-level-0').size.should > 0
end

And(/^Store image name on search result no "([^"]*)"$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    res = find_by_id("productresults")
    res.find('li.search-item', match: :first)
    $file_name = get_file_name res.all('li.search-item')[i].first('img')['src']
  end
end

Then(/^I should have a different result count$/) do
  i = extract_number find_by_id('totalItems').text
  i.should <= $search_result_count
end

And(/^There is an indication on search result no "([^"]*)" about variants$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    res = find_by_id "productresults"
    res.find('.search-item', match: :first)
    res.all('.search-item')[i].should have_content "Bu ürünün farklı seçenekleri bulunmaktadır."
  end
end

Then(/^There should be an indication that some items are not available$/) do
  find_by_id('productresults').should have_content "Bu ürün geçici olarak temin edilememektedir."
end