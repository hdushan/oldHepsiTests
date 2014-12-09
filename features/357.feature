#encoding: UTF-8

Feature: 357 - Customising Filter Module for Better Desktop Experience
  As a buyer
  I want to see all the filters exposed on the desktop, along with ability to filter w/o pressing apply
  So that I can narrow my results and choose a product quicker

  Scenario: Filtering a product in search results
    Given I visit main page
    And I search for "ayakkabı"
    And I select a sub category in search
    | Giyim / Ayakkabı | Erkek | Erkek Ayakkabı | Erkek Bot |
    When I apply a filter
    | Ayakkabı Tipi | Klasik |
    | Markalar      | Bambi  |
    | Numara        | 40     |
    Then There are some results available
    And I remove these filters
    | Numara              | 40 |
    | Markalar            | Bambi  |
    | Ayakkabı Tipi       | Klasik |

  Scenario: Filtering a product in browsing
    Given I visit main page
    And I navigate to Category
    | Oto, Bahçe Yapı Market | Hırdavat |
    And I select a sub category in browsing
    | Mobilya Hırdavatı | Tümünü Gör |
    When I apply a filter
      | Değerlendirme Puanı | 4 yıldız     |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Markalar            | Hafele       |
    Then There are some results available
    And I remove these filters
      | Markalar            | Hafele       |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Değerlendirme Puanı | 4 yıldız     |

  Scenario Outline: Sorting a product
    Given I visit main page
    And I search for "Spigen sgp galaxy note 4"
    When I sort with "<type>" filter
    Then Results are sorted according to "<type>" filter
    Examples:
    | type          |
    | smart         |
    | most-selling  |
    | lowest-price  |
    | highest-price |

  Scenario: Using clear button
    Given I visit main page
    And I search for "bebek bezi"
    And I apply a filter
      | Değerlendirme Puanı | 4 yıldız |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Sadece              | İndirimli Ürünler |
    When There are some results available
    Then I clear filters