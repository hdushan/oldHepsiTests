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

  @859
  Scenario Outline: See top sellers section on product details
    Given I visit main page
    When I search for "<item>"
    And I open search result no "1"
    Then There is a top sellers section
    Examples:
    | item |
    | K2HAYY25450 |
    | AILEBANEKSD110030 |
    | MTTEFFC22 |