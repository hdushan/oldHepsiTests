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
