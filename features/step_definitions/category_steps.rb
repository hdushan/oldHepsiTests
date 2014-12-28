#encoding: UTF-8

Then(/^I see (\d+) items in discounted products$/) do |items|
  expect(page.find('.widget.DiscountedProducts')).to have_content('İndirimli ürünler')
  expect(page.find('.widget.DiscountedProducts').all('.search-item').count).to be == items.to_i
end

And /^I click the bestsellers tab/ do
  find_by_id('bestSelling').click
end

Then(/^I see at least (\d+) items in top sellers$/) do |items|
  expect(page.find('.widget.TopSellerList')).to have_content('Çok Satanlar')
  expect(page.find('.widget.TopSellerList').all('.box.product').count).to be == items.to_i
end

Then(/^the first discounted product displays the expected fields$/) do
  first_discounted_product_entry = page.find('.widget.DiscountedProducts').first('.search-item')

  expect(first_discounted_product_entry).to have_selector('.title')
  expect(first_discounted_product_entry).to have_selector('.product-image-wrapper')
  expect(first_discounted_product_entry).to have_selector('.price')
  expect(first_discounted_product_entry).to have_selector('.product-old-price')
  expect(first_discounted_product_entry).to have_selector('.discount-badge')
end

Then(/^the first top seller product displays the expected fields$/) do
  first_top_seller_entry = page.find('.widget.TopSellerList').first('.box.product')

  expect(first_top_seller_entry).to have_selector('.title')
  expect(first_top_seller_entry).to have_selector('.product-image')
  expect(first_top_seller_entry).to have_selector('.price')
end

Then(/^I click the second discounted product$/) do
  product_entry = page.find('.widget.DiscountedProducts').all('.box.product')[1]
  @product_name = product_entry.find('.title').text
  product_entry.find('a').click
end

Then(/^I click the second top-seller product$/) do
  product_entry = page.find('.widget.TopSellerList').all('.box.product')[1]
  @product_name = product_entry.find('.title').text
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

Then(/^I should not see adult item "(.*?)" on CLP$/) do |adult_item_sku|
  page.find('#totalItems')
  set_wait_time 5
  page.should have_no_content (adult_item_sku)
  revert_to_default_wait_time
end