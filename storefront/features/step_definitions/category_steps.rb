# encoding: UTF-8
Then(/^I see (\d+) items in discounted products$/) do |items|
  expect(page.all('.discounted-product-container li').count.to_s).to eq items
end

Then(/^I see (\d+) items in top sellers$/) do |items|
  expect(page.all('.top-seller-container li').count.to_s).to eq items
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

Then(/^the first top seller product displays the expected fields$/) do
  first_top_seller_entry = page.first('.top-seller-container li')

  expect(first_top_seller_entry).to have_selector('.product-title')
  expect(first_top_seller_entry).to have_selector('.product-image-wrapper')
  expect(first_top_seller_entry).to have_selector('.product-price')
  expect(first_top_seller_entry).to have_selector('.ranking-growth')
end

Then(/^I click the second discounted product$/) do
  product_entry = page.all('.discounted-product-container li')[1]
  @product_name = product_entry.find('.product-title').text
  product_entry.find('a').click
end

Then(/^I click the second top-seller product$/) do
  product_entry = page.all('.top-seller-container li')[1]
  @product_name = product_entry.find('.product-title').text
  product_entry.find('a').click
end

When(/^I click on SEO link$/)do
  click_link('showCategoryInfo')
end

Then(/^I see a pop up with category title and some SEO text$/) do
  page.should have_selector('#categoryTitle')
  page.should have_content('Bilgisayar Fiyatları ve Modelleri')
end
