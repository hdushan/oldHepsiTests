#encoding: UTF-8
@storefront @product
Feature: Product page Add and Remove from basket
  As a buyer
  I want to be able to add and remove from basket
  So that I can purchase the item

  @323
  Scenario: Remove add to cart from product details when item is out of stock
    Given I visit main page
    When I search for "BD800472"
    And I open search result no "1"
    Then Add to cart button is not available on product details
#    And I am able to select different variants

  @318
  Scenario: Add to basket
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I search for "MTARCELIK6230BULAS"
    And I open search result no "1"
    And I am on product details
    When I add "1" product(s) to cart
    Then Cart icon should have an indication of "1"

  @318
  Scenario: Adding to basket without selecting a variant
    Given I visit main page
    And I search for "ZYPYON2897"
    When I open search result no "1"
    And I am on product details
    Then I should not be able to add to cart without a variant

  @93 @merchant_disabled
  Scenario: Add to basket from compatible products
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I search for "BD800104"
    And I open search result no "1"
    When I click on compatible products tab
    And I add compatible product no "3" to basket
    Then I see the cart item count is 1