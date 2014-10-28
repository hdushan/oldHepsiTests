@storefront
Feature: Category page is as expected
  
  Background:
    Given I am on the homepage
    When I visit the computers category landing page

    @373
    Scenario: Display top discounted products on desktop
      Then I see 10 items in discounted products
