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

Given(/^I click the 'add to basket' button$/) do
  find('button.add-to-basket.button-like-link').click
end

When(/^I click 'go to cart'$/) do
  click_link 'shoppingCart'
end

When(/^I click 'add one more'$/) do
  click_button 'addToCartAgain'
end

When(/^I click on the returns policy link$/) do
  click_link 'productReturnPolicy'
end

When /^I make the page half as wide/ do
  window_size = Capybara.page.driver.browser.manage.window.size
  Capybara.page.driver.browser.manage.window.resize_to(window_size[0]/2, window_size[1])
end

When /^I load the page on a 1280x1024 monitor/ do
  Capybara.page.driver.browser.manage.window.resize_to(1280, 1024)
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

Then(/^I see at least (\d+) reviews$/) do |num|
  wait_for_visibility(page, '.review-item', true)
  expect(all('.review-item').count).to be >= num.to_i
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
  expect(find_by_id("offering-price"))
  expect(first("img.product-image")['src']).to match @product_image
  expect(all('img.product-image').count).to be > 1
  expect(find_by_id('productDetailsCarousel'))
  expect(find_by_id('tabProductDesc'))
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
  page.should have_css('del#originalPrice', :visible => false)
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

Then /^I see the cart item count is (.*)/ do | cart_quantity_count |
  page.find_by_id('cartItemCount').should have_content(cart_quantity_count)
end

Then (/^I should see (\d*) color variants$/) do | color_count |
  all('.question').first.should have_content("renk")
  variant_container = all('.variant-container').first
  variant_container.all('div').count.should eql(color_count.to_i)	
end

And /^I see the default product image$/ do
  @default_image_src = page.find('.owl-item.active').find('.product-image')['src']
end

And /^I wait for all Ajax requests to complete/ do
  loop until page.evaluate_script('jQuery.active').zero?
end

When(/^I select the color (.*)/) do | color |
  page.find('label', :text=> color).click
end

Then /^I see a different image$/ do
  new_image = page.find('.owl-item.active').find('.product-image')['src']
  expect(@default_image_src).to_not eq(new_image)
end

Then /^I see no horizontal scroll bar/ do
  scroll_bar_present = page.execute_script("return document.documentElement.scrollWidth>document.documentElement.clientWidth;");
  expect(scroll_bar_present).to eq(false)
end

AfterStep('@658') do
  Capybara.page.driver.browser.manage.window.maximize
end

When /^I select the value (.*) from the (.*) dropdown$/ do | dropdown_value, dropdown_name |
  page.find_by_id(dropdown_name).find('option', :text=> dropdown_value).click
end

Then /^I see (.*) in the (.*) dropdown box$/ do | dropdown_value, dropdown_name |
  page.find_by_id(dropdown_name).value.should eq(dropdown_value)
end

And /^element with id (.*) is selected$/ do | variant_name |
  page.find_by_id(variant_name).should be_checked
end

Then /^I do not see the 'add to basket' button/ do
  expect(page).to_not have_selector('button.add-to-basket.button-like-link')
end

Then /^I should see the bestseller section$/ do
  page.should have_selector('.top-seller')
end