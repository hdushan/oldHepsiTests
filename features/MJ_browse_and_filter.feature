#encoding: UTF-8
@journey
  Feature: Browse and filter for mobile

    @mobile_merchant_disabled
    Scenario: Browse to a category
      Given I visit mobile main page
      And I clear cart items
      And I visit mobile main page
      When I navigate to Mobile_Category
        | Beyaz Eşya / Mutfak |
      Then I select a sub category in browsing
        | Beyaz Eşya & Ankastre  | Tümünü Gör |
      When There are some results available

    Scenario: Apply filter for mobile category
      Given I store search result count
      When I apply a filter on mobile
        | Markalar            | Samsung   |
        | Markalar            | Vestel    |
        | Değerlendirme Puanı | 4 yıldız  |
        | Kullanım Şekli      | Solo      |
      Then I should have a different result count

    Scenario: Add to cart from details
      Given I open search result no "6"
      When I add "4" product(s) to cart
      And Cart icon should have an indication of "1"
      And I go to checkout
      Then Product is listed in the checkout screen


