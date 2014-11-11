original_result= ""

And(/^I can see the results$/) do
  original_result = find("#totalItems").text
end

Given(/^I filter by first level category$/) do
  first('#categoryList li label').click
end

Given(/^I filter by brand$/) do
  first('#brandList li label').click
end

Given(/^I filter by rating$/) do
  first('#starRatingList li label').click
end

Given(/^I filter by price$/) do
  first('#otherFilterList-actual_price li label').click
end

Given(/^I filter by shipping style$/) do
  all('#otherFilterList-filterflag li label')[1].click
end

Given(/^I filter by case type$/) do
  first('#otherFilterList-851_dp li label').click
end

Given(/^I filter by material type$/) do
  first('#otherFilterList-380_dp li label').click
end

Given(/^I filter by super fast delivery$/) do
  first(:xpath, '//label[@for="sfcper20h0131zl013120gf6nderidekiler"]').click
end

When(/^I click load more results$/) do
  click_button "moreResult"
end

When(/^I clear active filters$/) do
  click_button 'btnClearFilters'
end

Then(/^I should only see products that fall under my preset range$/) do
  expect(find("#totalItems")).to_not have_content original_result
end

Then(/^I should see all results$/) do
  expect(find("#totalItems")).to have_content original_result
end

Then(/^I cannot click the clear filters button$/) do
  expect(find('#btnClearFilters')[:disabled]).to eq 'true'
end

Then(/^I should not see any selected filters$/) do
  all('#filterResults li input').each do |input|
    expect(input).to_not be_checked
  end
end