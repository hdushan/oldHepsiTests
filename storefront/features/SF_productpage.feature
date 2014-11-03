@storefront
Feature: Product page is as expected
  As a buyer
  I want to be able to see things on the product page
  So that I can decide on whether to purchase the item

  Background:
    Given I am on the homepage
    When I search for TELCEPIPH5C16GPM-N
    And I select a product from search results

  @143 @60 @19 @61 @62 @83
  Scenario: Display Product information
    Then I see the product information

  @56
  Scenario: Page title contains product name
    Then the page title contains the product name

  @84
  Scenario: Display product reviews
    Then I see 3 reviews
    And I can see the 'More Reviews' button

  @78
  Scenario: Display returns policy
    Given I see to link to view the returns policy
    When I click on the returns policy link
    Then I see the returns policy