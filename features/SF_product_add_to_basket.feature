#encoding: UTF-8
@storefront @product
Feature: Product page Add and Remove from basket
  As a buyer
  I want to be able to add and remove from basket
  So that I can purchase the item

  @118
  Scenario: I can add a procurable item to basket
    Given I select a product with SKU EAKSERELEKTBAT
    Then I should see the quantity box with a default of 1

  @118 @flaky
  Scenario: I can add multiple items to basket at once
    Given I select a product with SKU EAKSERELEKTBAT
    Then I add "5" product(s) to cart

  @118 @flaky
  Scenario: I cannot add a negative quantity of items to basket
    Given I select a product with SKU EAKSERELEKTBAT
    And I enter a quantity of -1
    When I add to cart
    Then I should see an invalid message notification

  @323
  Scenario: Remove add to cart from product details when item is out of stock
    Given I visit main page
    When I search for "BD800472"
    And I open search result no "1"
    Then Add to cart button is not available on product details
#    And I am able to select different variants

  @318 @326
  Scenario: Add to basket
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I search for "MTARCELIK6230BULAS"
    And I open search result no "1"
    And I am on product details
    When I add "1" product(s) to cart
    And I am on checkout screen
    Then Product is listed in the checkout screen
    And I return to previous page
    Then I see the cart item count is 1

  @318
  Scenario: Adding to basket without selecting a variant
    Given I visit main page
    And I search for "ZYPYON2897"
    When I open search result no "1"
    And I am on product details
    Then I should not be able to add to cart without a variant

  @93
  Scenario: Add to basket from compatible products
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I search for "BD800104"
    And I open search result no "1"
    When I click on compatible products tab
    And I add compatible product no "3" to basket
    And I am on checkout screen
    Then Product is listed in the checkout screen
    And I return to previous page
    Then I see the cart item count is 1