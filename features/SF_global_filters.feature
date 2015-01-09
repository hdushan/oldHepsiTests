#encoding: UTF-8
  Feature: Global Filters
    As a user
    I'd like to apply global filters
    In order to navigate results easier

  @722 @857 @854 @853 @869
  Scenario: Show global filter on homepage
    Given I visit main page
    Then I should see "Süper Hızlı Gönderiler" global filter on main page
    And I should see "İndirimli Ürünler" global filter on main page
    And I should see "Çok Satanlar" global filter on main page
    And I should see "Kargo Bedavalar" global filter on main page
    And I should see "Bugün Teslimat" global filter on main page

  @722 @857 @854 @853 @869
  Scenario Outline: Show global filter on CLP
    Given I visit main page
    When I navigate to Category
    | <category> | <sub_category> |
    Then I should see "Süper Hızlı Gönderiler" global filter on CLP
    And I should see "İndirimli Ürünler" global filter on CLP
    And I should see "Çok Satanlar" global filter on CLP
    And I should see "Kargo Bedavalar" global filter on CLP
    And I should see "Bugün Teslimat" global filter on CLP
    Examples:
    | category               | sub_category       |
    | Elektronik   | Isıtma ve Soğutma  |
    | Oto, Bahçe Yapı Market | Güvenlik           |
    | Anne, Bebek Oyuncak    | Emzirme            |
    | Kozmetik Kişisel Bakım | Parfüm & Deodorant |

  @722 @857 @854 @853 @869
  Scenario Outline: Use global filter from within a category
    Given I visit main page
    And I navigate to Category
    | Ev, Yaşam Ofis | Mobilya |
    When I apply global filter "<filter>" on "CLP"
    Then There are some results available
    And I select a sub category in search
    | Ev Dekorasyon | Mobilya |
    And I apply a filter
    | Değerlendirme Puanı | 4 yıldız     |
    And I sort with "lowest-price" filter
    And Results are sorted according to "lowest-price" filter
    And I see "<filter_for_clp>" global filter actively selected
    Examples:
    | filter                 | filter_for_clp |
    | Süper Hızlı Gönderiler | Süper hızlı gönderiler |
    | İndirimli Ürünler      | İndirimli ürünler      |
    | Çok Satanlar           | Çok Satanlar           |
    | Kargo Bedavalar        | Kargo Bedavalar        |
    | Bugün Teslimat         | Bugün Teslimat         |

#  @722 @857 @854
#  Scenario Outline: Stay on the same results when you click on global filter
#    Given I visit main page
#    And I navigate to Category
#      | Oto, Bahçe Yapı Market | Hırdavat |
#    When I apply global filter "<filter>" on "CLP"
#    And There are some results available
#    And I apply a filter
#    | Markalar | Hafele   |
#    And I store search result count
#    And I apply global filter "<filter>" on "CLP"
#    Then Current search results count should be same as the first one
#    Examples:
#    | filter                 |
#    | Süper hızlı gönderiler |
#    | İndirimli ürünler      |
#    | Çok Satanlar           |

  @722 @857 @854 @853 @869
  Scenario Outline: Use global filter from homepage
    Given I visit main page
    When I apply global filter "<filter>" on "homepage"
    Then There are some results available
    And I select a sub category in search
      | Giyim / Ayakkabı | Erkek |
    And I apply a filter
      | Değerlendirme Puanı | 4 yıldız  |
      | Markalar            | Blue Pony |
    And I sort with "highest-price" filter
    And Results are sorted according to "highest-price" filter
    And I see "<filter_on_results>" global filter actively selected
    Examples:
    | filter                 | filter_on_results      |
    | Süper Hızlı Gönderiler | Süper hızlı gönderiler |
    | İndirimli Ürünler      | İndirimli ürünler      |
    | Çok Satanlar           | Çok Satanlar           |
    | Kargo Bedavalar        | Kargo Bedavalar        |
    | Bugün Teslimat         | Bugün Teslimat         |

  @722 @857 @853
  Scenario Outline: Page title and description with super fast shipping global filter on CLP
    Given I visit main page
    When I apply global filter "<filter>" on "homepage"
    Then The page title is "<title>"
    And Page description contains "<description>"
  Examples:
    | filter                 | title | description |
    | Süper Hızlı Gönderiler | Süper Hızlı Logolu Ürünler 24 Saatte Kargoda | Sipariş ettiğiniz üründe süper hızlı logosu varsa, siparişiniz 24 saatte kargoda. Ayrıca kargo bedava ve hediye çeki fırsatı Hepsiburada.com'da. |
    | İndirimli Ürünler      | İndirimli Kampanyalı Ürünler En Uygun Fiyatla Burada | Hepsiburada.com'da indirime giren ürünler bu sayfada. İndirimli ürünler sayfamızı ziyaret etmeden online alışveriş yapmayın.             |
    | Kargo Bedavalar        | Kargo Bedava Ürünler & Kampanyalı Fiyatlar           | Hepsiburada.com'da Kargo bedava ürünler bu sayfada. Kargoya para harcamayın, ürünler ücretsiz ayağına gelsin.                            |

  @722 @857 @853
  Scenario Outline: Page title and description with super fast shipping global filter on CLP
    Given I visit main page
    And I navigate to Category
    | Ev, Yaşam Ofis | Elektrikli Ev Aletleri |
    When I apply global filter "<filter>" on "CLP"
    Then The page title is "<title>"
    And Page description contains "<description>"
   Examples:
    | filter                 | title | description |
    | Süper Hızlı Gönderiler | Süper Hızlı Logolu Ürünler 24 Saatte Kargoda | Sipariş ettiğiniz üründe süper hızlı logosu varsa, siparişiniz 24 saatte kargoda. Ayrıca kargo bedava ve hediye çeki fırsatı Hepsiburada.com'da. |
    | İndirimli Ürünler      | İndirimli Kampanyalı Ürünler En Uygun Fiyatla Burada | Hepsiburada.com'da indirime giren ürünler bu sayfada. İndirimli ürünler sayfamızı ziyaret etmeden online alışveriş yapmayın.             |
    | Kargo Bedavalar        | Kargo Bedava Ürünler & Kampanyalı Fiyatlar           | Hepsiburada.com'da Kargo bedava ürünler bu sayfada. Kargoya para harcamayın, ürünler ücretsiz ayağına gelsin.                            |

  @987
  Scenario: Clear filters on global filter
    Given I visit main page
    And I navigate to Category
      | Kitap, Müzik Film, Hobi | Kitap & Dergi |
    When I apply global filter "Süper Hızlı Gönderiler" on "CLP"
    And I store search result count
    And I apply a filter
      | Yazar               | Komisyon |
      | Değerlendirme Puanı | 3 yıldız |
    And I clear filters
    Then Current search results count should be same as the first one

    @1040
    Scenario: Global filters order on mainpage
      Given I visit main page
      Then I see this global filter order on mainpage
      | Kargo Bedavalar |
      | İndirimli ürünler |
      | Çok Satanlar      |
      | Süper hızlı gönderiler |
      | Bugün Teslimat         |

    @1040
    Scenario: Global filters order on global filters landing page
      Given I visit main page
      When I navigate to Category
      | Elektronik | Foto & Kamera |
      Then I see this global filter order on GFLP
      | Kargo Bedavalar |
      | İndirimli ürünler |
      | Çok Satanlar      |
      | Süper hızlı gönderiler |
      | Bugün Teslimat         |

    @1040
    Scenario: Global filters order on CLP
      Given I visit main page
      When I apply global filter "Çok Satanlar" on "homepage"
      Then I see this global filter order on CLP
      | Kargo Bedavalar |
      | İndirimli ürünler |
      | Çok Satanlar      |
      | Süper hızlı gönderiler |
      | Bugün Teslimat         |