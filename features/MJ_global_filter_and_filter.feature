#encoding: UTF-8
@journey

  Feature: Using Global Filters in Mobile

    Scenario Outline: Visit Mobile Main Page and go to Global filters page
      Given I visit mobile main page
      When I apply global filter "<global_filter>" on "homepage"
      Then There are some results available
      And I should see indicators for "<global_filter>"
    Examples:
      | global_filter |
      | Kargo Bedavalar |
      | Süper Hızlı Gönderiler |
      | İndirimli Ürünler |
      | Çok Satanlar |

    Scenario: Apply a filter on Kargo Bedavalar Global filters page
      Given I visit mobile main page
      When I apply global filter "Kargo Bedavalar" on "homepage"
      And There are some results available
      And I store search result count
      And I apply a filter on mobile
        | Değerlendirme Puanı | 4 Yıldız |
      Then I should have a different result count
      And I am still on mobile page

    Scenario: Apply a filter on Süper Hızlı Gönderiler Global filters page
      Given I visit mobile main page
      When I apply global filter "Süper Hızlı Gönderiler" on "homepage"
      And There are some results available
      And I store search result count
      And I apply a filter on mobile
        | Değerlendirme Puanı | 5 Yıldız |
      Then I should have a different result count
      And I am still on mobile page

    Scenario: Apply a filter on Çok Satanlar Global filters page
      Given I visit mobile main page
      When I apply global filter "Çok Satanlar" on "homepage"
      And There are some results available
      And I store search result count
      And I apply a filter on mobile
        | Değerlendirme Puanı | 3 Yıldız |
      Then I should have a different result count
      And I am still on mobile page

    Scenario: Apply a filter on İndirimli Ürünler Global filters page
      Given I visit mobile main page
      When I apply global filter "İndirimli Ürünler" on "homepage"
      And There are some results available
      And I store search result count
      And I apply a filter on mobile
        | Değerlendirme Puanı | 2 Yıldız |
      Then I should have a different result count
      And I am still on mobile page