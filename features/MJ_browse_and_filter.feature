#encoding: UTF-8
@journey
  Feature: Browse and filter for mobile

      Scenario: Browse to a category
      Given I visit mobile main page
      When I navigate to Mobile_Category
        | Beyaz Eşya / Mutfak |
      Then I select a sub category in mobile
        | Beyaz Eşya & Ankastre  | Bulaşık Makineleri |
      When There are some results available
#Scenario: Apply filter for mobile category
      Given I store search result count
      When I apply a filter on mobile
        | Markalar            | Samsung   |
        | Markalar            | Vestel    |
        | Değerlendirme Puanı | 4 yıldız  |
        | Kullanım Şekli      | Solo      |
      Then I should have a different result count
#Scenario: Add to cart from details
      Given I open search result no "6"
      When I add "4" product(s) to cart
      And I am on checkout screen on mobile
      Then Product is listed in the checkout screen
      And I return to previous page
      Then Cart icon should have an indication of "2"
      And I clear cart items
      And I return to previous page
      Then Cart icon should have an indication of "0"


