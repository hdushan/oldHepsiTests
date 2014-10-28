@storefront
@16
Feature: Basic search
  As a buyer
  I want to search for products
  So that I can find a list with the product I was looking for

  Background:
    Given I am on the homepage

  Scenario: Searching, with results
    When I search for iPhone
    Then I should see a list of iPhone results

  Scenario: Searching, with no results
    When I search for iPhonethatdoesnotexist
    Then I should see no results page