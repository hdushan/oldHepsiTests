@25 @storefront

Feature: Filter by one type of rating
  As a buyer
  I want to filter by rating
  So that I can find specific products easier

  Scenario: Filter by rating
    Given I filter by rating
    Then I should only see products that fall under my preset range