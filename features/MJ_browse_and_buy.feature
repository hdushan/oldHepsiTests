#encoding: UTF-8
  @journey
  Feature: Browse and buy for mobile

    Scenario: Browse to a category
      Given I visit mobile main page
      When I navigate to Mobile_Category
      | Foto / Kamera |
      Then I select a sub category in mobile
      | Fotoğraf Makinesi ve Kamera | Outdoor / Sualtı Fotoğraf Makineleri |
      When There are some results available
#Scenario: Add to cart from CLP
      Given I click load more results
      When I add search result no "5" to cart from search results for mobile
      And I am on checkout screen on mobile
      And Product is listed in the checkout screen
      And I return to previous page
      Then Cart icon should have an indication of "1"
#Scenario: Add to cart from details
      Given I click load more results
      And I open search result no "35"
      When I add "3" product(s) to cart
      And I am on checkout screen on mobile
      Then Product is listed in the checkout screen
      And I return to previous page
      Then Cart icon should have an indication of "2"
      And I clear cart items
      And I return to previous page
      Then Cart icon should have an indication of "0"