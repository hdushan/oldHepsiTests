#encoding: UTF-8
@journey
Feature: Make a search and test both sorting and filter clearing
  As a customer
  I want to be able to clear filters and sort results
  In order to have a more refined result set

  Scenario: Visit site
    Given I visit main page
    Then I am at main page

  Scenario: Search for a product by title
    When I search for "bebek bezi"
    Then There are some results available

  Scenario: Apply Filter and remove them step by step
    Given I apply a filter
      | Değerlendirme Puanı | 4 yıldız |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Sadece              | İndirimli Ürünler |
    When There are some results available
    Then I remove these filters
      | Sadece              | İndirimli Ürünler |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Değerlendirme Puanı | 4 yıldız |

  Scenario: Apply a filter and use clear filters
    Given I search for "bebek bezi"
    And I apply a filter
      | Değerlendirme Puanı | 4 yıldız |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Sadece              | İndirimli Ürünler |
    When There are some results available
    Then I clear filters

  Scenario: Search for a product by title
    When I search for "Spigen sgp galaxy note 4"
    Then There are some results available

  Scenario Outline: Validate Sorting Types
    When I sort with "<type>" filter
    Then Results are sorted according to "<type>" filter
    Examples:
    | type         |
    | smart        |
    | most-selling  |
    | lowest-price  |
    | highest-price |

  Scenario: End Test
    Then clear data
    And close browser
