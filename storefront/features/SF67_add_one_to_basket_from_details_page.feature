@storefront
@67
Feature: Add one to basket from details page
  As a buyer
  I want add a product to my basket from the details page
  So that I can finalise my purchase

  Background:
    Given I have an empty cart
    And I am on the homepage
    When I searched for iphone

  @regression
  Scenario: Add iphone to cart
  	Given I select the iphone from search results
    When I add to cart
    Then I should see the notification

    When I click on the shopping cart
  	Then I should see the product in the cart

