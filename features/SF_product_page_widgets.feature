#encoding: UTF-8
@storefront @product
Feature: BestSellers and other product page widgets
  As a buyer
  I want to be able to see bestseller and other widgets on the product page
  So that I can find something I like

  @97
  Scenario: Bestseller section
    Given I select a product with SKU EAKSERELEKTBAT
    Then I should see the bestseller section

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

  @94 @recommended_products_on_product_detail_page_enabled
  Scenario: Display suggested products when available and selecting a product takes me to the details page
    Given I select a product with SKU TELCEPSAMN9000-B
    Then I see a maximum of 10 products in the suggestions area
    And I see a picture associated with each product
    And when I select the first suggested product
    Then I am on product details

  @94
  Scenario: If the product has no suggestions, there should not be a section
    Given I select a product with SKU OUTFEY51113
    Then I do not see suggestions

  @859
  Scenario: Top sellers on product details
    Given I visit main page
    When I search for "AILEBNDBL2401"
    And I open search result no "1"
    Then There is a top sellers section

  @1087
  Scenario: Totals text in top sellers should not be a link
    Given I visit main page
    And I search for "iphone"
    When I open search result no "1"
    Then Totals in topsellers section should not be a link