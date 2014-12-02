#encoding: UTF-8

Given /^I select a product from search results$/ do
  # product_links = all(:xpath, "//li[@class = 'search-item'][.//@class = 'product-price']")
  # product = product_links[rand(product_links.length)]
  # @product_image = product.first('.product-image-wrapper img')['src'].split('/').last
  # @product_name = product.first('.product-title').text
  # click_link(@product_name)
  search_item = find_by_id('productresults').first('.search-item')
  @product_name = search_item.first('.product-title').text
  @product_image = search_item.first('.product-image-wrapper img')['src'].split('/').last
  click_link(@product_name)
end

When(/^I click the 'add to basket' button on results page$/) do
  find('button.add-to-basket.button-like-link').click
end

Then(/^I should see a list of (.*) results$/) do | search_term |
  expect(first('.search-item a')).to have_content search_term
end

Then(/^I should see no results page$/) do
  expect(find(".no-results-container"))
end

Then(/^I should see (.*) visible results$/) do | amount_of_visible_results |
  sleep(2)
  expect(all(".search-item").count.to_s).to eq amount_of_visible_results
end

Then(/^I see either a price or an unavailable statement for each result$/) do
  expect(all('.product-price').count + all('.procurement-status').count).to eq all('.search-item').count
end

Then(/^I see a product image for each result$/) do
  expect(all('.product-image-wrapper').count).to eq all('.search-item').count
end

Then(/^I see ratings for all products$/) do
  expect(all('.search-item .product-rating').count).to eq all('.search-item').count
end

Then(/^I do not see a breadcrumb trail$/) do
  page.should_not have_selector('.breadcrumbs-wrapper')
end

When /^I click on a product from the search results$/ do
  page.all('.product-image-wrapper').first.click
end

Then /^I should see a breadcrumb trail$/ do
  page.should have_selector('.breadcrumbs-wrapper')
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
  page.should_not have_selector('.discount-badge')
end

Then /^I see an indicator of free shipping associated with the item$/ do
  page.find('.shipping-status').should have_content("Kargo Bedava")
end

<<<<<<< HEAD:storefront/features/step_definitions/search_result_steps.rb
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

And /^the second level categories have the number of items within the first level category$/ do
  page.all('.category-level-1').each do | category | 
     expect(category.find(:css, 'label.filter-label span').text).should_not eq('')
  end
end

And /^I no longer see the other first level categories$/ do
  page.all('.category-level-0').count.should == 1
end

And /^I have the action to return to the first level categories$/ do 

=======
When(/^I search for an item that is in stock and has fast delivery configured$/) do
  steps %{When I search for "TELCEPSAMI9060-B"}
end

Then(/^I see an indicator of fast delivery associated with the first item$/) do
  page.find('.shipping-status').should have_content("Süper Hızlı")
>>>>>>> 7a6173ab23775832844c97e41fe5b5e8290483ef:features/step_definitions/search_result_steps.rb
end