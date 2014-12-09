#encoding: UTF-8

Feature: 343 - Display Filter by Product Specific Attributes
  As a browser
  I want filter products by their attributes
  So that i can quickly find the product i'm looking for.

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

  Scenario: Specific filters should appear on search results
    Given I search for "Michelin lastik"
    When I apply a filter
    | Jant Çapı       | 17    |
    | Kullanım Türü   | Binek |
    | Taban Genişliği | 225mm |
    Then There are some results available

  Scenario: Specific filters should appear on browsing results
    Given I navigate to Category
    | Süpermarket Petshop | Petshop |
    And I select a sub category in browsing
    | Kedi | Kedi Mamaları | Tümünü Gör |
    When I apply a filter
      | Yaş           | 1-7 Yaş  |
      | Ürün Kilogram | 10-15 kg |
    Then There are some results available