#encoding: UTF-8
@storefront @cart
Feature: Add to basket from details page

  @67
  Scenario: Add to cart
    Given I visit main page
    And Clear cart items
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    And I select a product from search results
    And I add "2" product(s) to cart
    And I go to checkout
    Then Product is listed in the checkout screen

  @116
  Scenario: Preserve cart on page reload
    Given I visit main page
    And Clear cart items
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    Then I select a product from search results
    And I add "1" product(s) to cart
    And I go to checkout
    Then Product is listed in the checkout screen
    When I reload the page
    Then Product is listed in the checkout screen

  @116
  Scenario: Remove cart on cookie deletion
    Given I visit main page
    And Clear cart items
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    Then I select a product from search results
    And I add "1" product(s) to cart
    And I go to checkout
    Then Product is listed in the checkout screen
    When I clear the browsers cookies
    And I reload the page
    Then I should see an empty cart

  @304
  Scenario: Number of items in cart increases after adding an item from product details page
#    Given I clear sessions
#    And I am on the homepage
#    And I have an empty cart
    Given I visit main page
    And Clear cart items
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    Then I select a product from search results
    When I add to cart
    Then I see the cart item count is 1

  @113
  Scenario: Adding to basket from results page when product does not have variants
    Given I visit main page
    And Clear cart items
    And I see the cart item count is 0
    Given I search for "BD800476"
    When I click the 'add to basket' button on results page
    Then I see the cart item count is 1

  @113
  Scenario: Cannot add to basket from results page when product has variants
    Given I visit main page
    And Clear cart items
    And I see the cart item count is 0
    Given I search for "AYKP38462CGBBZ37"
    Then I do not see the 'add to basket' button