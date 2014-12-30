#encoding: UTF-8
  @mobile_journey
  Feature: Browse and buy for mobile

    Scenario Outline: Browse a category and buy
      Given I visit mobile main page
      And Clear cart items
      And I navigate to Mobile_Category
      | Foto / Kamera |
      And I select a sub category in browsing
      | Fotoğraf Makinesi ve Kamera | Tümünü Gör |
      When I click more results on mobile
      And I add search result no "3" to cart on mobile
      Then Cart icon should have an indication of "1"
      And I open search result no "32" on mobile
      And I add "3" product(s) to cart
      Then
      Examples: