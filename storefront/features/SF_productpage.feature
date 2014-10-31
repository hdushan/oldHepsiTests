@storefront
Feature: Product page is as expected
  As a buyer
  I want to be able to see things on the product page
  So that I can decide on whether to purchase the item

  Background:
    Given I am on the homepage
    When I search for iPhone
    And I select a product from search results

  @143
  Scenario: Display one product price
    Then I see product price with tax

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

  @60  @19
  Scenario: Display multiple product images
    Then I see multiple product images

  @62
  Scenario: Display product description
    Then I see a product description
