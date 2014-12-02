@storefront
Feature: Search page is as expected
  As a buyer
  I want to be able to search for things
  So that I can find the item I am looking for

  Background:
    Given I am on the homepage

  @143 @18
  Scenario: Display product prices
    When I search for "Samsung"
    Then I see either a price or an unavailable statement for each result

  @19
  Scenario: Display product images
    When I search for "Samsung"
    Then I see a product image for each result

  @17
  Scenario: View results page
    When I search for "Samsung"
    Then I should see 20 visible results

  @17
  Scenario: Clicking more results
    When I search for "Samsung"
    When I click load more results
    Then I should see 40 visible results

  @42
  Scenario: Display discount percentage for a discounted product
    When I search for "Samsung"
    Then I should see the discount badge

  @42
  Scenario: Do not display discount percentage for an undiscounted product
    When I search for "OYUNAR522"
    Then I should not see the discount badge

  @429
  Scenario: Do not show breadcrumb trail when searching or filtering
    When I search for "Samsung"
    Then I do not see a breadcrumb trail

  @249
  Scenario: Display breadcrumbs on product details
    When I search for "Samsung"
    When I click on a product from the search results
    Then I should see a breadcrumb trail

  @137
  Scenario: Display if a product has more variants on the results page
    When I search for "Samsung"
    Then I should see the variants message for the product

  @137
  Scenario: Display if a product has more variants on the results page
    When I search for "1210704100152BEY"
    Then I should not see the variants message for the product

  @30
  Scenario: See free shipping on search results
    When I search for "EVPH42PFK6109"
    Then I see an indicator of free shipping associated with the item

  @253
  Scenario: Seeing second level subcategories
    When I choose the category Bilgisayar 
    Then the results are updated to reflect items in the category
    And I see one or more second level categories
    And the second level categories have the number of items within the first level category
    And I no longer see the other first level categories
    And I have the action to return to the first level categories

  @36
  Scenario: See fast delivery on search results
    When I search for an item that is in stock and has fast delivery configured
    Then I see an indicator of fast delivery associated with the first item

  @36
  Scenario: Dont show Fast delivery if not in stock
    When I search for an item that is not in stock and has fast delivery configured
    Then I should not see an indicator of fast delivery associated with the first item