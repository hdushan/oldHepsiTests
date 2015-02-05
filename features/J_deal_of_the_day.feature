#encoding: UTF-8
@storefront @product
Feature: Deal of the Day
  As a buyer
  I want to be able to see the deal of the day products
  So that I can grab a bargain

  @730 @726 @1095 @727
  Scenario: All deal of the day items should have stock indicators
    Given I visit main page
    When I go to deals of the day page
    And I am on deals of the day page
    Then All deals of the day should have stock indicators
    And I open search result no "1"
 #Scenario: See time left for Deal of the Day items
    Then I should see all deal of the day counter in details
 #Scenario: See stock left for Deal of the Day items
   Then I should see stock left in details