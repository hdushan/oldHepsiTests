#encoding: UTF-8
@mobile_journey
  Feature: Browse and filter for mobile

    Scenario: Browse to a category
      Given I visit mobile main page
#      And I clear cart items
#      And I visit mobile main page
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


