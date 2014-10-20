productName = ""

Given /^I am on the homepage$/ do
  visit '/'
end

Given /^I select the iphone from search results$/ do
  productName = first('.search-item a').text
  click_link(productName)
end

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

When /^There should b$/ do
  within ".product-price-wrapper" do
    click_button "addToCart"
  end
end

When /^I searched for (.*)$/  do | search_term |
  fill_in 'q', :with => "#{search_term}"
  click_button "buttonProductSearch"
end

When(/^I click on the shopping cart$/) do
  click_link "shoppingCart"
end

Then /^I should see the product in the cart$/ do
  expect(find('.cart-item', :count => 1))
  expect(find('.cart-item').text have_content productName)
end

Then(/^I should see the notification$/) do
  find('#notification').should be_visible
  sleep(3)
  find('#notification').should_not be_visible
end