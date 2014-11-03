# -*- coding: utf-8 -*-
Given(/^I have an empty cart$/) do
  steps %{
      Given I am on the homepage
  }

  click_link "shoppingCart"
  click_link "clearCart"
end

When /^I select a product with SKU (.*)$/ do |sku|
  steps %{
    Given I am on the homepage
    Given I search for #{sku}
    Given I select a product from search results
  }
end

When /^I add to cart$/ do
  within ".product-price-wrapper" do
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

Then(/^I should see two of the product in the cart$/) do
  steps %{
      Given I should see the product in the cart
  }
  expect(find('.cart-item .quantity').text).to eq '2'
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
