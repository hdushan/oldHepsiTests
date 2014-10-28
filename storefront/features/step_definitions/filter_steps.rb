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
  first('#starRatingList li label').click
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

When(/^I clear active filters$/) do
  click_button 'btnClearFilters'
end

Then(/^I should only see products that fall under my preset range$/) do
  expect(find("#totalItems")).to_not have_content originalResult
end

Then(/^there should be (\d+) results visible results$/) do |amount_of_visible_results|
  sleep(1)
  expect(all(".search-item").count.to_s).to eq amount_of_visible_results
end

Then(/^I should see all results$/) do
  expect(find("#totalItems")).to have_content originalResult
end

Then(/^I cannot click the clear filters button$/) do
  expect(find('#btnClearFilters')[:disabled]).to eq 'true'
end

Then(/^I should not see any selected filters$/) do
  all('#filterResults li input').each do |input|
    expect(input).to_not be_checked
  end
end