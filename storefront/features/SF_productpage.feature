@storefront
Feature: Product page is as expected
  As a buyer
  I want to be able to see things on the product page
  So that I can decide on whether to purchase the item

  Background:
    Given I am on the homepage
    When I searched for iphone
    And I select the iphone from search results

  @143
  Scenario: Display one product price
    Then I see product price with tax
