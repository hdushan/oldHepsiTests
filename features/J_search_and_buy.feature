#encoding: UTF-8
@journey
  Feature: Use search to find a product
    As a customer
    I want to be able to search a product
    In order to add it to cart

  Scenario: Visit site
    Given I visit main page
    Then I am at main page

  Scenario: Search for a product by title
    When I search for "kitap"
    Then There are some results available

  Scenario: Go to product details and add to cart
    Given I open search result no "1"
    When I am on product details
    Then I add "3" product(s) to cart

  Scenario: Go to checkout
    Given I go to checkout
    When I am on checkout screen
    Then Product is listed in the checkout screen

  Scenario: End Test
    Then clear data
    And close browser

