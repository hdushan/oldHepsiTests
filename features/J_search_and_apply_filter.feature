#encoding: UTF-8
@journey
Feature: Search and apply a filter to find a product
  As a customer
  I want to be able to search for a product and apply a filter
  In order to add it to cart

  @clear_data_and_close_browser_after_test
  Scenario: Visit site
    Given I visit main page
    Then I am at main page
#Scenario: Search for a product by title
    When I search for a product "BOOK"
    Then There are some results available
#Scenario: Apply Filter
    Given I select a sub category in search
      | Kitap Film Müzik | Kitap | Dergi |
    And There are some results available
    When I apply a filter
      | Yazar | Kolektif |
      | Değerlendirme Puanı | 5 yıldız |
    Then There are some results available
#Scenario: Go to product details and add to cart
    Given I open search result no "2"
    When I am on product details
    Then I add "3" product(s) to cart
#Scenario: Go to checkout
    When I am on checkout screen
    Then Product is listed in the checkout screen
    When I visit main page
    Then I see the cart item count is 1
