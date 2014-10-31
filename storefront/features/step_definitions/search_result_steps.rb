Given /^I select the iPhone from search results$/ do
  @productName = first('.search-item a .product-title').text
  click_link(@productName)
end

Given /^I select a product from search results$/ do
  product_links = all('.search-item a')
  product = product_links[rand(product_links.length)]
  @productImage = product.first('.product-image-wrapper img')['src'].split('/').last
  @productName = product.first('.product-title').text
  click_link(@productName)
end

Then(/^I should see a list of (.*) results$/) do | search_term |
  expect(first('.search-item a')).to have_content search_term
end

Then(/^I should see no results page$/) do
  expect(find(".no-results-container"))
end

Then(/^I should see (\d+) results visible results$/) do |amount_of_visible_results|
  sleep(1)
  expect(all(".search-item").count.to_s).to eq amount_of_visible_results
end

Then(/^I see either a price or an unavailable statement for each result$/) do
  expect(all('.product-price').count + all('.procurement-status').count).to eq all('.search-item').count
end

Then(/^I see a product image for each result$/) do
  expect(all('.product-image-wrapper').count).to eq all('.search-item').count
end

Then(/^I see ratings for all products$/) do
  sleep(30)
  expect(all('.search-item .product-rating').count).to eq all('.search-item').count
end