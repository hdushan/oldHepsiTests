originalResult = ""
When(/^I click load more results$/) do
  click_link "moreResult"
end

Given(/^I filter by price$/) do
  originalResult = find("#totalItems").text
  click_button "btnExpand-actual_price"
  first('#otherFilterList-actual_price li label').click
end

Then(/^I should only see products that fall under my preset range$/) do
  expect(find("#totalItems").text should_not have_content originalResult)
end