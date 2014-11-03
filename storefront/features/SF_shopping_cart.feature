@storefront
Feature: Add to basket from details page

  Background:
    Given I have an empty cart
    And I am on the homepage
    When I search for OUTINT1BWAK67000N
    Then I select a product from search results

  @67
  Scenario: Add to cart
    When I add to cart
    Then I should see the notification
    When I click on the shopping cart
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
    And I click on the shopping cart
    Then I should see two of the product in the cart

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
