@storefront
Feature: Add to basket from details page

  Background:
    Given I have an empty cart
    And I am on the homepage
    When I searched for iphone
    Then I select the iphone from search results

  @67
  Scenario: Add iphone to cart
    When I add to cart
    Then I should see the notification
    When I click on the shopping cart
  	Then I should see the product in the cart

  @460
  Scenario: Add to cart and transform button
    When I add to cart
    Then I should see the 'go to cart' button
    When I click 'go to cart'
    Then I should see the product in the cart




