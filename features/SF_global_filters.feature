# encoding: UTF-8
  Feature: Global Filters
    As a user
    I'd like to apply global filters
    In order to navigate results easier

  @722
  Scenario: Show superfast shipping filter on homepage
    Given I visit main page
    Then I should see "Süper Hızlı Gönderiler" global filter on main page

  @722
  Scenario Outline: Show superfast shipping filter on CLP
    Given I visit main page
    When I navigate to Category
    | <category> | <sub_category> |
    Then I should see "Süper hızlı gönderiler" global filter on CLP
    Examples:
    | category               | sub_category       |
    | Elektronik Beyaz Eşya  | Isıtma ve Soğutma  |
    | Oto, Bahçe Yapı Market | Güvenlik           |
    | Anne, Bebek Oyuncak    | Emzirme            |
    | Kozmetik Kişisel Bakım | Parfüm & Deodorant |

  @722
  Scenario: Use superfast shipping filter from within a category
    Given I visit main page
    And I navigate to Category
    | Süpermarket Petshop | İçecek Ürünleri |
    When I apply global filter "Süper hızlı gönderiler" on "CLP"
    Then There are some results available
    And I select a sub category in search
    | Süpermarket | İçecek Ürünleri | Çaylar | Demlik / Dökme Çaylar |
    And I apply a filter
    | Markalar            | Lipton       |
    | Değerlendirme Puanı | 4 yıldız     |
    | Fiyat Aralığı       | 0 TL - 25 TL |
    And I sort with "lowest-price" filter
    And Results are sorted according to "lowest-price" filter
    And I see "Süper hızlı gönderiler" global filter actively selected

  @722
  Scenario: Stay on the same results when you click on super fast shipping
    Given I visit main page
    And I navigate to Category
      | Oto, Bahçe Yapı Market | Hırdavat |
    When I apply global filter "Süper hızlı gönderiler" on "CLP"
    And There are some results available
    And I apply a filter
    | Markalar | 3M   |
    And I store search result count
    And I apply global filter "Süper hızlı gönderiler" on "CLP"
    Then Current search results count should be same as the first one

  @722
  Scenario: Use superfast shipping filter from homepage
    Given I visit main page
    When I apply global filter "Süper Hızlı Gönderiler" on "homepage"
    Then There are some results available
    And I select a sub category in search
      | Spor Outdoor | Spor / Fitness | Fitness - Kondisyon | Kondisyon Aletleri |
    And I apply a filter
      | Fonksiyon Tipi | El Yayı |
      | Markalar       | Delta   |
    And I sort with "highest-price" filter
    And Results are sorted according to "highest-price" filter
    And I see "Süper hızlı gönderiler" global filter actively selected
    
  @722
  Scenario: Page title and description with super fast shipping global filter on homepage
    Given I visit main page
    When I apply global filter "Süper Hızlı Gönderiler" on "homepage"
    Then The page title is "Süper Hızlı Logolu Ürünler 24 Saatte Kargoda"
    And Page description contains "Sipariş ettiğiniz üründe süper hızlı logosu varsa, siparişiniz 24 saatte kargoda. Ayrıca kargo bedava ve hediye çeki fırsatı Hepsiburada.com'da."

  @722
  Scenario: Page title and description with super fast shipping global filter on CLP
    Given I visit main page
    And I navigate to Category
    | Ev, Yaşam Ofis | Elektrikli Ev Aletleri |
    When I apply global filter "Süper hızlı gönderiler" on "CLP"
    Then The page title is "Süper Hızlı Logolu Ürünler 24 Saatte Kargoda"
    And Page description contains "Sipariş ettiğiniz üründe süper hızlı logosu varsa, siparişiniz 24 saatte kargoda. Ayrıca kargo bedava ve hediye çeki fırsatı Hepsiburada.com'da."

  @987
  Scenario: Clear filters on global filter
    Given I visit main page
    And I navigate to Category
      | Kitap, Müzik Film, Oyun | Kitap & Dergi |
    When I apply global filter "Süper hızlı gönderiler" on "CLP"
    And I store search result count
    And I apply a filter
      | Yazar               | Komisyon |
      | Değerlendirme Puanı | 3 yıldız |
    And I clear filters
    Then Current search results count should be same as the first one
