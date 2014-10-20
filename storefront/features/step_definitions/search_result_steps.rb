Given /^I select the iphone from search results$/ do
  @productName = first('.search-item a').text
  click_link(@productName)
end

Then(/^I should see a list of (.*) results$/) do | search_term |
  expect(first('.search-item a').text have_content search_term)
end

Then(/^I should see no results page$/) do
  expect(find(".no-results-container"))
end