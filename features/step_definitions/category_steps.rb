# encoding: UTF-8
Then(/^I see (\d+) items in discounted products$/) do |items|
  expect(page.find('.discounted-product-container')).to have_content('İndirimli ürünler')
  expect(page.find('.discounted-product-container').all('.search-item').count).to be == items.to_i
end

And /^I click the bestsellers tab/ do
  find_by_id('bestSelling').click
end

Then(/^I see at least (\d+) items in top sellers$/) do |items|
  expect(page.find('.top-seller-container')).to have_content('En çok satanlar')
  expect(page.find('.top-seller-container').all('.search-item').count).to be == items.to_i
end

Then(/^the first discounted product displays the expected fields$/) do
  first_discounted_product_entry = page.find('.discounted-product-container').first('.search-item')

  expect(first_discounted_product_entry).to have_selector('.product-title')
  expect(first_discounted_product_entry).to have_selector('.product-image-wrapper')
  expect(first_discounted_product_entry).to have_selector('.product-price')
  expect(first_discounted_product_entry).to have_selector('.product-old-price')
  expect(first_discounted_product_entry).to have_selector('.discount-badge')
  expect(first_discounted_product_entry).to have_selector('.product-offerflags')
end

Then(/^the first top seller product displays the expected fields$/) do
  first_top_seller_entry = page.find('.top-seller-container').first('.search-item')

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


Then(/^I should see Fast Shipping offered for product "(.*?)"$/) do |product_name|
  matching_product=nil
  products = page.all("#productResult .product-detail")
  products.each do |curr_product|
    curr_product_name = curr_product.find("h3").text
    if curr_product_name == product_name
      matching_product=curr_product
      break
    end
  end
  matching_product.all(".shipping-status", :text=>/Süper Hızlı/).size.should == 1
end