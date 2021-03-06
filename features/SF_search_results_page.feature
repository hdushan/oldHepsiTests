#encoding: UTF-8
@storefront
Feature: Search page is as expected
  As a buyer
  I want to be able to search for things
  So that I can find the item I am looking for

  @143 @18
  Scenario: Display product prices
    Given I am on the homepage
    When I search for "Samsung"
    Then I see either a price or an unavailable statement for each result

  @19
  Scenario: Display product images
    Given I am on the homepage
    When I search for "Samsung"
    Then I see a product image for each result

  @17
  Scenario: View results page
    Given I am on the homepage
    When I search for "Samsung"
    Then I should see 20 visible results

  @17
  Scenario: Clicking more results
    Given I am on the homepage
    When I search for "Samsung"
    When I click load more results
    Then I should see 40 visible results

  @42
  Scenario: Display discount percentage for a discounted product
    Given I am on the homepage
    When I search for "Samsung"
    Then I should see the discount badge

  @42
  Scenario: Do not display discount percentage for an undiscounted product
    Given I am on the homepage
    When I search for "OYUNAR522"
    Then I should not see the discount badge

  @429
  Scenario: Do not show breadcrumb trail when searching or filtering
    Given I am on the homepage
    When I search for "Samsung"
    Then I do not see a breadcrumb trail

  @249
  Scenario: Display breadcrumbs on product details
    Given I am on the homepage
    When I search for "Samsung"
    When I click on a product from the search results
    Then I should see a breadcrumb trail

  @137
  Scenario: Display if a product has more variants on the results page
    Given I am on the homepage
    When I search for "Samsung"
    Then I should see the variants message for the product

  @442
  Scenario: Show related keywords for a search in the results page
    Given I am on the homepage
    When I search for "samsung"
    Then I should see 3 related search keywords for "samsung"
    And On clicking a related keyword "samsung s5"
    Then I should see search results of that keyword "samsung s5"

  @442
  Scenario: Show related categories for a search in the results page
    Given I am on the homepage
    When I search for "samsung"
    Then I should see 1 related search categories for "samsung"
    And On clicking a related category "Kampanyalar / Samsung"
    Then I should see search results with each result having the word "samsung" in the product name

  @30
  Scenario: See free shipping on search results
    Given I am on the homepage
    When I search for "usb bellek"
    Then I see an indicator of free shipping associated with the item

  @30
  Scenario: See free shipping on campaigns on CLP
    Given I am on the homepage
    Given I navigate to the computers category landing page
    Then I see an indicator of free shipping associated with at least one item

  @253
  Scenario: Filter by categories
    Given I am on the homepage
    When I search for "Samsung"
    Then I see an area for filtering by category
    And the category level 0 has the number of items
 
  @253
  Scenario: Seeing second level subcategories
    Given I am on the homepage
    When I search for "Samsung"
    When I choose the category Bilgisayar 
    When I choose the category Aksesuarlar
    Then the results are updated to reflect items in the category
    And I see one or more second level categories
    And the category level 1 has the number of items
    And I can return to the first level category Bilgisayar

  @36
  Scenario: See fast delivery on search results
    Given I am on the homepage
    When I search for an item "TELCEPSAMI9060-B" that is in stock and has fast delivery configured
    Then I see an indicator of fast delivery associated with the item

  @323
  Scenario: Remove add to cart from search results when item is out of stock
    Given I visit main page
    When I search for "BD800472"
    Then Add to cart button is not available on result no "1"

  @319
  Scenario: Number of results
    Given I visit main page
    When I search for "deterjan"
    Then There are more than "20" results
    And There are "20" results displayed

  @319
  Scenario: Number of results
    Given I visit main page
    And I search for "bebek bezi"
    And There are more than "20" results
    And There are "20" results displayed
    When I click load more results
    Then There are "40" results displayed
    And I click load more results
    And There are "60" results displayed

  @319
  Scenario: No results
    Given I visit main page
    When I search for "ahndarabberete"
    Then I should see no results page

#  @256
#  Scenario: More brands button on CLP
#    Given I visit main page
#    And I navigate to Category
#    | Elektronik | Bilgisayar/Tablet |
#    When There are "10" brands in brand filter
#    And There is more brands button
#    Then I press more brands button
#    And There are more than "10" brands in the filter area

#  @256
#  Scenario: More brands button on search results
#    Given I visit main page
#    And I search for "kitap"
#    When There are "10" brands in brand filter
#    And There is more brands button
#    Then I press more brands button
#    And There are more than "10" brands in the filter area

  @957
  Scenario: Handling empty search
    Given I visit main page
    When I search for ""
    Then I don't get the error page

  @342
  Scenario: Show product not available indication on results page
    Given I visit main page
    When I search for "sennheiser"
    Then There should be an indication that some items are not available

  @992
  Scenario: Click show more results button more than once
    Given I visit main page
    When I click discounted items global filter
    Then I should be able to click show more products multiple times

#  @1020
#  Scenario: Use more filters button on filter fields
#    Given I visit link "/akilli-telefon-c-371946"
#    When There are more filters button on filters
#    Then I click every more filters button and expand filters

  Scenario: More results button on CLP
    Given I visit main page
    And I navigate to Category
    | Elektronik | Bilgisayar/Tablet |
    When There are "20" results displayed
    And I click load more results
    Then There are "40" results displayed
    And I click load more results
    Then There are "60" results displayed
    And I click load more results
    Then There are "80" results displayed

  @1043
  Scenario: Display search results count text
    Given I visit main page
    When I search for "telefon"
    Then There is a search result count message for search "telefon"