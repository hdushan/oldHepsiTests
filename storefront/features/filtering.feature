#@28 @storefront Feature: Filter by one brand
#@27 @storefront Feature: Filter by 1st level category
#@25 @storefront Feature: Filter by one type of rating



@23 @storefront
Feature: Filter by Price Range
  As a buyer
  I want to filter my results by price
  So that I can choose a product within a certain price range

  Background:
    Given I am on the homepage
    When I searched for iphone

  Scenario: Selecting a price range
    Given I filter by price
    Then I should only see products that fall under my preset range

#  Scenario: Clicking more results
#    Given I filter by price
#    When I click load more results
#    Then the filter should still be applied
