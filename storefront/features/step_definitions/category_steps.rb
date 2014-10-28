Then(/^I see (\d+) items in discounted products$/) do |items|
  expect(page.all('.discounted-product-container li').count).to be(10)
end

Then(/^the first discounted product displays the expected fields$/) do
  first_discounted_product_entry = page.first('.discounted-product-container li')

  expect(first_discounted_product_entry).to have_selector('.product-title')
  expect(first_discounted_product_entry).to have_selector('.product-image-wrapper')
  expect(first_discounted_product_entry).to have_selector('.product-price')
  expect(first_discounted_product_entry).to have_selector('.product-old-price')
  expect(first_discounted_product_entry).to have_selector('.discount-badge')
  expect(first_discounted_product_entry).to have_selector('.product-offerflags')
end

Then(/^I click the second discounted product$/) do
  second_discounted_product_entry = page.all('.discounted-product-container li')[1]
  @productName = second_discounted_product_entry.find('.product-title').text
  second_discounted_product_entry.find('a').click
end
