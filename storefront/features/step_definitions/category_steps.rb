Then(/^I see (\d+) items in discounted products/) do |items|
  expect(page.all('.discounted-product-container li').count.to_s).to eq items
end
