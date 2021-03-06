#encoding: UTF-8
@storefront @cart
Feature: Add to basket from details page

  @67
  Scenario: Add to cart
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I see the cart item count is 0
    When I search for "AYKGREM16998MA42"
    And I select a product from search results
    And I add "2" product(s) to cart
    And I am on checkout screen
    Then Product is listed in the checkout screen
    And I return to previous page
    Then I see the cart item count is 1

  @116
  Scenario: Preserve cart on page reload
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I see the cart item count is 0
    When I search for "AYKGREM16998MA42"
    Then I select a product from search results
    And I add "1" product(s) to cart
    And I am on checkout screen
    Then Product is listed in the checkout screen
    When I reload the page
    Then Product is listed in the checkout screen

  @116
  Scenario: Remove cart on cookie deletion
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I see the cart item count is 0
    When I search for "AYKGREM16998MA42"
    Then I select a product from search results
    And I add "1" product(s) to cart
    And I am on checkout screen
    Then Product is listed in the checkout screen
    When I clear the browsers cookies
    And I reload the page
    Then I should see an empty cart
    And I visit main page
    Then I see the cart item count is 0

  @304
  Scenario: Number of items in cart increases after adding an item from product details page
#    Given I clear sessions
#    And I am on the homepage
#    And I have an empty cart
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I see the cart item count is 0
    When I search for "AYKGREM16998MA42"
    Then I select a product from search results
    When I add "1" product(s) to cart
    And I am on checkout screen
    Then Product is listed in the checkout screen
    And I return to previous page
    Then I see the cart item count is 1

  @113
  Scenario: Adding to basket from results page when product does not have variants
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I see the cart item count is 0
    Given I search for "BD800476"
    When I click the 'add to basket' button on results page
    And I am on checkout screen
    Then Product is listed in the checkout screen
    And I return to previous page
    Then I see the cart item count is 1

  @113
  Scenario: Cannot add to basket from results page when product has variants
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I see the cart item count is 0
    Given I search for "AYKP38462CGBBZ37"
    Then I do not see the 'add to basket' button

#  @1112  @ignore
#  Scenario: Check cart indicator and search suggestions on CLP
#    Given I visit main page
#    And I clear cart items
#    And I visit main page
#    When I apply global filter "İndirimli Ürünler" on "homepage"
#    And I add search result no "1" to cart from search results
#    Then Cart icon should have an indication of "1"
#    When I navigate to Category
#    | Oto, Bahçe, Yapı Market | Bahçe & Balkon |
#    And I add search result no "1" to cart from search results
#    Then Cart icon should have an indication of "2"
#    When I search for "kitap"
#    And I add search result no "1" to cart from search results
#    Then Cart icon should have an indication of "3"
#    When I open search result no "3"
#    And I add "3" product(s) to cart
#    Then Cart icon should have an indication of "4"
#    When I navigate to Category
#    | Kozmetik Kişisel Bakım | Cilt & Vücut Ürünleri |
#    Then Cart icon should have an indication of "4"
#    When I have input sam into search
#    Then I see suggestions based on sam