#encoding: UTF-8
When(/^I sort by bestseller$/) do
  find('button.button.light').click
  click_link 'bestSelling'
end

When(/^I sort by lowest price$/) do
  find('button.button.light').click
  click_link 'lowestPrice'
end

When(/^I sort by highest price$/) do
  find('button.button.light').click
  click_link 'highestPrice'
end

Then(/^I see the bestseller button is not selected$/) do
  find('button.button.light').click
  expect(find('#bestSelling')[:class]).to_not include 'selected'
  find('button.button.light').click
end

Then(/^I see the lowest price button is selected$/) do
  find('button.button.light').click
  expect(find('#lowestPrice')[:class]).to include 'selected'
  find('button.button.light').click
end

Then(/^I see the bestseller button is selected$/) do
  find('button.button.light').click
  expect(find('#bestSelling')[:class]).to include 'selected'
  find('button.button.light').click
end

Then(/^I see the best matching button is selected$/) do
  find('button.button.light').click
  expect(find('#bestMatching')[:class]).to include 'selected'
  find('button.button.light').click
end

Then(/^I see the highest price button is selected$/) do
  find('button.button.light').click
  expect(find('#highestPrice')[:class]).to include 'selected'
  find('button.button.light').click
end

Then(/^I see results lowest price first$/) do
  find('.search-item', match: :first)
  price_list = prices_to_list(all('.search-item'))
  expect(price_list).to eq price_list.sort
end

Then(/^I see results highest price first$/) do
  find('.search-item', match: :first)
  price_list = prices_to_list(all('.search-item'))
  expect(price_list).to eq price_list.sort{ |x,y| y <=> x }
end