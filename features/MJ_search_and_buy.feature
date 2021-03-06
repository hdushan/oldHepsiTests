#encoding: UTF-8
@journey
  Feature: Search and buy for mobile


    Scenario: Search products and buy an item
      Given I visit mobile main page
      And I search for "bebek"
      When I open search result no "1"
      And I am on product details
      And I return to previous page
      Then There are some results available
      And I see related search keywords on search result page
      | bebek bezi | bebek arabası | bebek beşikleri |
      And I see related search categories on search result page
      | Süpermarket / Bebek Bezleri ve Alt Açma |
      And I open search result no "7"
      And I add "4" product(s) to cart
#Scenario: Go to checkout
      And I am on checkout screen on mobile
      Then Product is listed in the checkout screen
      And I return to previous page
      Then Cart icon should have an indication of "1"
      And I clear cart items
      And I return to previous page
      Then Cart icon should have an indication of "0"