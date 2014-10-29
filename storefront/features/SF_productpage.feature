@storefront
Feature: Product page is as expected
  As a buyer
  I want to be able to see things on the product page
  So that I can decide on whether to purchase the item

  Background:
    Given I am on the homepage
    When I search for iPhone
    And I select the iPhone from search results

  @143
  Scenario: Display one product price
    Then I see product price with tax

  @19
  Scenario: Display product image
    Then I see the product image

  @56
  Scenario: Page title contains product name
    Then the page title contains the product name
