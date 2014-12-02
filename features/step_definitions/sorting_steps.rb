When(/^I sort by bestseller$/) do
  click_link 'bestSelling'
end

When(/^I sort by lowest price$/) do
  click_link 'lowestPrice'
end

When(/^I sort by highest price$/) do
  click_link 'highestPrice'
end

Then(/^I see the bestseller button is not selected$/) do
  expect(find('#bestSelling')[:class]).to_not include 'selected'
end

Then(/^I see the lowest price button is selected$/) do
  expect(find('#lowestPrice')[:class]).to include 'selected'
end

Then(/^I see the bestseller button is selected$/) do
  expect(find('#bestSelling')[:class]).to include 'selected'
end

Then(/^I see the best matching button is selected$/) do
  expect(find('#bestMatching')[:class]).to include 'selected'
end

Then(/^I see the highest price button is selected$/) do
  expect(find('#highestPrice')[:class]).to include 'selected'
end

Then(/^I see results lowest price first$/) do
  price_list = prices_to_list(all('.search-item'))
  expect(price_list).to eq price_list.sort
end

Then(/^I see results highest price first$/) do
  price_list = prices_to_list(all('.search-item'))
  expect(price_list).to eq price_list.sort{ |x,y| y <=> x }
end