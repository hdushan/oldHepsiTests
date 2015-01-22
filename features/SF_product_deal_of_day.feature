#encoding: UTF-8
@storefront @product
Feature: Product page for Deal of Day products
  As a buyer
  I want to be able to see things on a deal of day product page
  So that I can decide on whether to purchase the item

  @726 @1095
  Scenario: See the timer on Deal of the Day product detail pages
    Given I visit main page
    When I search for "TELCEPNOKLU620-B"
    And I open search result no "1"
    Then I should see deal of the day counter in details

 @727 @1095
 Scenario: See stock left for Deal of the Day items
   Given I visit main page
   When I search for "EVLG49UB820V"
   And I open search result no "1"
   Then I should see stock left for deal of the day items for "EVLG49UB820V"

  @730
  Scenario: All deal of the day items should have stock indicators
    Given I visit main page
    When I go to deals of the day page
    And I am on deals of the day page
    Then All deals of the day should have stock indicators