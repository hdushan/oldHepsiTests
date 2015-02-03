#encoding: UTF-8
When(/^I sort by bestseller$/) do
  find('button.button.light').click
  find_by_id('sortResultsHeader').find('a', text: 'Öne Çıkanlar').click
end

When(/^I sort by lowest price$/) do
  find('button.button.light').click
  find_by_id('sortResultsHeader').find('a', text: 'En düşük fiyat').click
end

When(/^I sort by highest price$/) do
  find('button.button.light').click
  find_by_id('sortResultsHeader').find('a', text: 'En yüksek fiyat').click
end

Then(/^I see the bestseller button is not selected$/) do
  find('button.button.light').click
  set_wait_time 30
  expect(find_by_id('sortResultsHeader').find('a', text: 'Öne Çıkanlar')[:class]).to_not include 'selected'
  revert_to_default_wait_time
  find('button.button.light').click
end

Then(/^I see the lowest price button is selected$/) do
  find('button.button.light').click
  expect(find_by_id('sortResultsHeader').find('a', text: 'En düşük fiyat')[:class]).to include 'selected'
  find('button.button.light').click
end

Then(/^I see the bestseller button is selected$/) do
  find('button.button.light').click
  expect(find_by_id('sortResultsHeader').find('a', text: 'Öne Çıkanlar')[:class]).to include 'selected'
  find('button.button.light').click
end

Then(/^I see the best matching button is selected$/) do
  find('button.button.light').click
  expect(find_by_id('sortResultsHeader').find('a', text: 'Akıllı sıralama')[:class]).to include 'selected'
  find('button.button.light').click
end

Then(/^I see the highest price button is selected$/) do
  find('button.button.light').click
  expect(find_by_id('sortResultsHeader').find('a', text: 'En yüksek fiyat')[:class]).to include 'selected'
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