#encoding: UTF-8
@journey
Feature: Browse categories to find a product
  As a customer
  I want to be able to browse a product
  In order to add it to cart

  @merchant_enabled
  Scenario: Visit site
    Given I visit main page
    Then I am at main page

  Scenario: Browse Category
    When I navigate to Category
    | Elektronik Beyaz Eşya | Bilgisayar Tablet |
    Then There are some results available

  Scenario: Go to product details and add to cart
    Given I open search result no "1"
    When I am on product details
    Then I add "2" product(s) to cart

  Scenario: Go to checkout
    Given I go to checkout
    When I am on new checkout screen
    Then Product is listed in the checkout screen

  Scenario: End Test
    Then clear data
    And close browser