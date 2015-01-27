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

  @1092 @725
  Scenario: Check deal of the day link and deal of the day main page
    Given I visit main page
    When I click deal of the day link
    Then I am on deals of the day page

  @190
  Scenario: Displaying deals on homepage
    Given I visit main page
    When There are some items in deal of the day carousel
    Then Original prices should be displayed in deal of the day items
    And Deal of the day items have titles

  @1092
  Scenario: Check details for a deal of the day
    Given I visit main page
    When I click deal of the day link
    Then I am on deals of the day page
    When I open deal of the day no "1"
    Then Product details contain "Günün Teklifi"

  @190
  Scenario: Displaying discounted prices on deal of the day products
    Given I visit main page
    When There are some items in deal of the day carousel
    Then Discounted prices should be displayed in deal of the day items

  @190
  Scenario: Clicking through on a deal
    Given I visit main page
    When There are some items in deal of the day carousel
    Then I should be able to visit every item in deal of the day carousel

  @467
Scenario: Check for original prices on deal of the day carousel
  Given I visit main page
  And I am at main page
  When There are some items in deal of the day carousel
  Then Original prices should be displayed in deal of the day items