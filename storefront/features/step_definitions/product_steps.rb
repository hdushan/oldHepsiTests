# -*- coding: utf-8 -*-
Given(/^I have an empty cart$/) do
  url = current_url
  click_link "shoppingCart"
  click_link "clearCart"
  visit url
end

When /^I select a product with SKU (.*)$/ do |sku|
  steps %{
    Given I am on the homepage
    Given I search for #{sku}
    Given I select a product from search results
  }
end

When /^I add to cart$/ do
  within "#addToCartForm" do
    click_button "addToCart"
  end
end

When(/^I click on the shopping cart$/) do
  click_link "shoppingCart"
end

When(/^I click 'go to cart'$/) do
  click_link 'linkToCart'
end

When(/^I click 'add one more'$/) do
  click_button 'addToCartAgain'
end

When(/^I click on the returns policy link$/) do
  click_link 'productReturnPolicy'
end

Then /^I should see the product in the cart$/ do
  expect(find('.cart-item', :count => 1))
  expect(find('.cart-item').text have_content @product_name)
end

Then(/^I should see (\d+) of the product in the cart$/) do |num|
  steps %{
      Given I should see the product in the cart
  }
  expect(find('.cart-item .quantity').text).to eq num
end

Then(/^I should see the notification$/) do
  wait_for_visibility(page, '#notification', true)
  wait_for_visibility(page, '#notification', false)
end

Then(/^I should see the 'go to cart' button$/) do
  wait_for_visibility(page, '#linkToCart', true)
end

Then(/^I should see the 'add one more' button$/) do
  wait_for_visibility(page, '#addToCartAgain', true)
end

Then(/^I should see an empty cart$/) do
  expect(page).to_not have_selector '.cart-item'
end

Then(/^I see the details page for the selected product$/) do
  expect(page.find('#product-name').text).to eq @product_name
end

Then(/^I see a result with product price and tax$/) do
  expect(first(".product-price"))
end

Then(/^the page title contains the product name$/) do
  expect(page.title).to include(@product_name)
end

Then(/^I see (\d+) reviews$/) do |num|
  expect(all('.review-item').count.to_s).to eq num
end

Then(/^I can see the 'More Reviews' button$/) do
  expect(find('#showMoreComments'))
end

Then(/^I see to link to view the returns policy$/) do
  expect(find('#productReturnPolicy'))
end

Then(/^I see the returns policy$/) do
  expect(find('#productReturnPolicyText'))
end

Then(/^I see the super fast delivery flag$/) do
  # nb: 'per H' is standing in for 'Süper Hızlı' as couldn't work out
  # how to match encoded string correctly
  expect(first('#fastShipping').text).to match 'per H'
end

Then(/^I see the product information$/) do
  expect(find("#offering-price"))
  expect(first("img.product-image")['src']).to match @product_image
  expect(all('img.product-image').count).to be > 1
  expect(find('#carousel'))
  expect(find('#tabProductDesc'))
  expect(find('.detail-main .product-rating'))
end

Then(/^I see the option to select a variant with prices$/) do
  variant_container = find('.variant-container-with-prices')
  all_price_labels = variant_container.all('.price-label')
  expect(all_price_labels.count).to be > 1
  expect(variant_container).to have_selector('input')
end

Then(/^I see no variant with prices is selected$/) do
  variant_container = find('.variant-container-with-prices')
  variant_container.all('input[type=radio]').each do | radio_button |
    radio_button.should_not be_checked
  end
end

Then(/^I see an error message asking me to make a selection$/) do
  wait_for_visibility(page, 'div #notification', true)
end

When(/^I select the first variant with price$/) do
  @URL = current_url
  all('.variant-container-with-prices .price-label').first.click
end

Then(/^I see the the variant with price is checked$/) do
  variant_container = find('.variant-container-with-prices')
  expect(variant_container.all('input[type=radio]').first).to be_checked
end

Then(/^I view the payment installments information$/) do
  first('#productPaymentInstallment').click
end

Then(/^I see at least one payment installment table$/) do
  all('.paymentInstallmentTable', :minimum => 1)
end

Then(/^I can view the product tech specs$/) do
  first('#productTechSpec').click
  all('.tech-spec', :minimum => 1)
end

Then(/^I see text indicating that free shipping is available$/) do
  expect(find('#fastShipping').text).to match "Kargo Bedava"
end

Then(/^I see the original price (.*) on the product with sku (.*)$/) do | price, sku |
  find_by_id(sku).should have_content price
end

Then(/^I see the original price (.*) on the product details page$/) do | price |
  find('del#originalPrice').should have_content price
end

Then(/^I see product return information specific to media/) do
  find_by_id('productReturnPolicyText').should have_content("İncelediğiniz ürün, Mesafeli Sözleşmelere Dair Yönetmeliğin 7.")
end

And(/^I see the discount percentage of (.*)$/) do | discount |
  find('#product-discount-rate del').should have_content discount
end

Then(/^I do not see a discount price$/) do
  page.should_not have_css('del#orininalPrice')
end

Then(/^there are (\d*) variants displayed$/) do | number |
    within('.product-variants-wrapper') do
      page.all('.variant-container').count.should eql(number.to_i)
    end
  end

And(/^the variants should have no default$/) do
  page.all('.radio-variant').each do | variant |
    variant.should_not be_checked
  end
end

And(/^I see the discount percentage$/) do
  expect(find('#product-discount-rate'))
end
