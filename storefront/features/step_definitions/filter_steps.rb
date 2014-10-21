originalResult = ""
When(/^I click load more results$/) do
  click_button "moreResult"
end

Given(/^I filter by price$/) do
  originalResult = find("#totalItems").text
  click_button "btnExpand-actual_price"
  first('#otherFilterList-actual_price li label').click
end

Then(/^I should only see products that fall under my preset range$/) do
  expect(find("#totalItems").text should_not have_content originalResult)
end

Then(/^there should be (\d+) results visible results$/) do |amount_of_visible_results|
  expect(all(".search-item").count should equal? amount_of_visible_results)
end