#encoding: UTF-8
@storefront
Feature: Filter category results

  @343
  Scenario: Filter by specific attribute
    Given I am on the homepage
    And I navigate to Category
    | Elektronik Beyaz Eşya | Telefon |
    And I can see the results
    When I filter by material type
    Then I should only see products that fall under my preset range

  @36
  Scenario: Show fast shipping indicator in category results page for product that offers fast shipping
    Given I am on the homepage
    And I navigate to Category
      | Elektronik Beyaz Eşya | Telefon |
    When I apply a filter
    | Markalar            | Samsung   |
    | İşletim Türü        | Android   |
    Then I should see Fast Shipping offered for product "Samsung i9060 Galaxy Grand Neo"

  @745 
  Scenario: Sorting CLP results when applied filter
    Given I am on the homepage
    And I navigate to Category
      | Giyim, Takı Aksesuar | Çocuk Giyim |
    When I apply a filter
      | Markalar  | Köstebek  |
      | Beden     | 5 Yaş |
    And There are some results available
    And I store filter results
    And I sort with "most-selling" filter
    Then I should have same items in the results
    When I sort with "lowest-price" filter
    Then I should have same items in the results
    When I sort with "highest-price" filter
    Then I should have same items in the results
    When I sort with "bestMatching" filter
    Then I should have same items in the results

  @357
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

  @357
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

  @357
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

  @357
  Scenario: Using clear button
    Given I visit main page
    And I search for "bebek bezi"
    And I apply a filter
      | Değerlendirme Puanı | 4 yıldız |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Markalar            | Prima |
    When There are some results available
    Then I clear filters

