#encoding: UTF-8
@journey
Feature: Make a search and test both sorting and filter clearing
  As a customer
  I want to be able to clear filters and sort results
  In order to have a more refined result set

    @clear_data_and_close_browser_after_test
  Scenario: Visit site
    Given I visit main page
    Then I am at main page
#Scenario: Search for a product by title
    When I search for a product "BABY_PRODUCT"
    Then There are some results available
#Scenario: Apply Filter and remove them step by step
    Given I apply a filter
      | Değerlendirme Puanı | 4 yıldız |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Markalar            | Prima |
    When There are some results available
    Then I remove these filters
      | Markalar            | Prima |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Değerlendirme Puanı | 4 yıldız |
#Scenario: Apply a filter and use clear filters
    Given I search for a product "BABY_PRODUCT"
    And I apply a filter
      | Değerlendirme Puanı | 4 yıldız |
      | Fiyat Aralığı       | 0 TL - 25 TL |
      | Markalar            | Prima |
    When There are some results available
    Then I clear filters
#Scenario: Search for a product by title
    When I search for a product "GALAX_NOTE_4"
    Then There are some results available
#Scenario Outline: Validate Sorting Types
    When I sort with "smart" filter
    Then Results are sorted according to "smart" filter
    When I sort with "most-selling" filter
    Then Results are sorted according to "most-selling" filter
    When I sort with "lowest-price" filter
    Then Results are sorted according to "lowest-price" filter
    When I sort with "highest-price" filter
    Then Results are sorted according to "highest-price" filter
