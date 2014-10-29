Given /^I select the iPhone from search results$/ do
  @productName = first('.search-item a .product-title').text
  click_link(@productName)
end

Then(/^I should see a list of (.*) results$/) do | search_term |
  expect(first('.search-item a')).to have_content search_term
end

Then(/^I should see no results page$/) do
  expect(find(".no-results-container"))
end

Then(/^I see a result with product price and tax$/) do
  expect(first(".product-price"))
end

Then(/^there should be (\d+) results visible results$/) do |amount_of_visible_results|
  sleep(1)
  expect(all(".search-item").count.to_s).to eq amount_of_visible_results
end

Then(/^I see all results with either a price or an unavailable statement$/) do
  expect(all('.product-price').count + all('.procurement-status').count).to eq all('.search-item').count
end