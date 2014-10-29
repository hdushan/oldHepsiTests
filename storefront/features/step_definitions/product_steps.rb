Given(/^I have an empty cart$/) do
  steps %{
      Given I am on the homepage
  }

  click_link "shoppingCart"
  click_link "clearCart"
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

Then /^I should see the product in the cart$/ do
  expect(find('.cart-item', :count => 1))
  expect(find('.cart-item').text have_content @productName)
end

Then(/^I should see the notification$/) do
  wait_for_visibility(page, '#notification', true)
  wait_for_visibility(page, '#notification', false)
end

Then(/^I see product price with tax$/) do
  expect(find("#offering-price"))
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
  expect(page.find('#product-name').text).to eq @productName
end

Then(/^I see a result with product price and tax$/) do
  expect(first(".product-price"))
end

Then(/^I see the product image$/) do
  expect(first(".product-image"))
end

Then(/^the page title contains the product name$/) do
  expect(page.title).to include(@productName)
end
