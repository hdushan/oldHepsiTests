@141 @storefront

Feature: Filter by shipping style
  As a buyer
  I want to filter my results by shipping style
  So that I can choose a product within shipping category

  Background:
    Given I am on the homepage
    When I searched for iphone

  Scenario: Selecting a price range
    Given I filter by shipping style
    Then I should only see products that fall under my preset range