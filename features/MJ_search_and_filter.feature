#encoding: UTF-8
@journey
  Feature: Search and filter for mobile

    @mobile_merchant_disabled
    Scenario: Search products and filter an item
      Given I visit mobile main page
      And I search for "kalem"
      When I apply a filter on mobile
      | Kategoriler | Kırtasiye / Ofis |
      | Markalar    | Faber-Castell    |
      | Değerlendirme Puanı | 3 yıldız |
      And I open search result no "2"
      And I am on product details
      And I add "2" product(s) to cart

    Scenario: Go to checkout
      When I go to checkout
      Then Product is listed in the checkout screen