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