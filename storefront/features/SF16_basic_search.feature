@storefront
@16
Feature: Basic search
  As a buyer
  I want to search for products
  So that I can find a list with the product I was looking for

  Background:
    Given I am on the homepage

  @regression
  Scenario: Searching, with results
    When I searched for iphone
    Then I should see a list of iphone results

  @regression
  Scenario: Searching, with no results
    When I searched for iphonethatdoesnotexist
    Then I should see no results page