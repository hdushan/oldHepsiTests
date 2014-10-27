originalResult = ""

Given(/^I filter by first level category$/) do
  originalResult = find("#totalItems").text
  first('#categoryList li label').click
end

Given(/^I filter by brand$/) do
  originalResult = find("#totalItems").text
  first('#brandList li label').click
end

Given(/^I filter by rating$/) do
  originalResult = find("#totalItems").text
  all('#starRatingList li label')[3].click
end

Given(/^I filter by price$/) do
  originalResult = find("#totalItems").text
  first('#otherFilterList-actual_price li label').click
end

Given(/^I filter by shipping style$/) do
  originalResult = find("#totalItems").text
  all('#otherFilterList-filterflag li label')[1].click
end

When(/^I click load more results$/) do
  click_button "moreResult"
end

Then(/^I should only see products that fall under my preset range$/) do
  expect(find("#totalItems").text should_not have_content originalResult)
end

Then(/^there should be (\d+) results visible results$/) do |amount_of_visible_results|
  expect(all(".search-item").count should equal? amount_of_visible_results)
end