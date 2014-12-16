#encoding: UTF-8
@storefront @cart @merchant_enabled
Feature: Add to basket from details page

  @67
  Scenario: Add to cart
    Given I clear sessions
    And I am on the homepage
    And I have an empty cart
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    Then I select a product from search results
    When I add to cart
    Then I should see the notification
    When I click 'go to cart'
    Then I should see the product in the cart

  @116
  Scenario: Preserve cart on page reload
    Given I clear sessions
    And I am on the homepage
    And I have an empty cart
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    Then I select a product from search results
    Given I add to cart
    And I wait for all Ajax requests to complete
    And I click 'go to cart'
    When I reload the page
    Then I should see the product in the cart

  @116
  Scenario: Remove cart on cookie deletion
    Given I clear sessions
    And I am on the homepage
    And I have an empty cart
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    Then I select a product from search results
    Given I add to cart
    And I click 'go to cart'
    When I clear the browsers cookies
    And I reload the page
    Then I should see an empty cart

  @304
  Scenario: Number of items in cart increases after adding an item from product details page
    Given I clear sessions
    And I am on the homepage
    And I have an empty cart
    And I see the cart item count is 0
    When I search for "MTSUNOCKE03"
    Then I select a product from search results
    When I add to cart
    Then I see the cart item count is 1

  @113
  Scenario: Adding to basket from results page when product does not have variants
    Given I clear sessions
    And I am on the homepage
    And I have an empty cart
    And I see the cart item count is 0
    Given I search for "BD800476"
    When I click the 'add to basket' button on results page
    Then I see the cart item count is 1

  @113
  Scenario: Cannot add to basket from results page when product has variants
    Given I clear sessions
    And I am on the homepage
    And I have an empty cart
    And I see the cart item count is 0
    Given I search for "AYKP38462CGBBZ37"
    Then I do not see the 'add to basket' button