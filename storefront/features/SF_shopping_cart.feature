@storefront @cart
Feature: Add to basket from details page

  Background:
    Given I am on the homepage
    And I have an empty cart
    And I see the cart item count is 0
    When I search for MTSUNOCKE03
    Then I select a product from search results

  @67
  Scenario: Add to cart
    When I add to cart
    Then I should see the notification
    When I click 'go to cart'
    Then I should see the product in the cart

  @460
  Scenario: Add to cart and click 'go-to-cart'
    When I add to cart
    Then I should see the 'go to cart' button
    When I click 'go to cart'
    Then I should see the product in the cart

  @460 @failing
  Scenario: Add to cart and click 'add-one-more'
    When I add to cart
    Then I should see the 'add one more' button
    When I click 'add one more'
    And I click 'go to cart'
    Then I should see 2 of the product in the cart

  @116
  Scenario: Preserve cart on page reload
    Given I add to cart
    And I click 'go to cart'
    When I reload the page
    Then I should see the product in the cart

  @116
  Scenario: Remove cart on cookie deletion
    Given I add to cart
    And I click 'go to cart'
    When I clear the browsers cookies
    And I reload the page
    Then I should see an empty cart

  @304
  Scenario: Number of items in cart increases after adding an item from product details page
    When I add to cart
    Then I see the cart item count is 1