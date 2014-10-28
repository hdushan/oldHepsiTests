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
  expect(find("#linkToCart").should be_visible)
end

When(/^I click 'go to cart'$/) do
  click_link 'linkToCart'
end