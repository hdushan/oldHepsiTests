When(/^I sort by bestseller$/) do
  click_link 'bestSelling'
end

Then(/^I see the bestseller button is selected$/) do
  expect(find('#bestSelling')[:class]).to include 'selected'
end