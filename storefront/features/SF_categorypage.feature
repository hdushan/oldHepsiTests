@storefront
Feature: Category page is as expected
  
  Background:
    Given I am on the homepage
    And I visit the computers category landing page

    @373 @failing
    Scenario: Display top discounted products on desktop
      Then I see 10 items in discounted products
      And the first discounted product displays the expected fields

    @373
    Scenario: Clicking through to a product
      When I click the second discounted product
      Then I see the details page for the selected product
