@storefront
Feature: Search page is as expected
  As a buyer
  I want to be able to search for things
  So that I can find the item I am looking for

  Background:
    Given I am on the homepage
    When I search for iPhone

  @143
  Scenario: Display one product price
    Then I see a result with product price and tax

  @17
  Scenario: View results page
    Then there should be 20 results visible results

  @17
  Scenario: Clicking more results
    When I click load more results
    Then there should be 40 results visible results




