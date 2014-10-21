@28 @storefront

Feature: Filter by one brand
  As a buyer
  I want to filter by rating
  So that I can find specific products easier

  Background:
    Given I am on the homepage
    When I searched for iphone

    Scenario: Filter by rating
      Given I filter by brand
      Then I should only see products that fall under my preset range