#encoding: UTF-8
  @journey
  Feature: Browse and buy for mobile

    @mobile_merchant_disabled
    Scenario: Browse to a category
      Given I visit mobile main page
      And I clear cart items
      And I visit mobile main page
      When I navigate to Mobile_Category
      | Foto / Kamera |
      Then I select a sub category in mobile
      | Fotoğraf Makinesi ve Kamera | Tümünü Gör |
      When There are some results available

    Scenario: Add to cart from CLP
      Given I click load more results
      When I add search result no "5" to cart from search results
      Then Cart icon should have an indication of "1"

    Scenario: Add to cart from details
      Given I click load more results
      And I open search result no "35"
      When I add "3" product(s) to cart
      And I go to checkout
      Then Product is listed in the checkout screen