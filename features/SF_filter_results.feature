#encoding: UTF-8
@storefront @reliable

Feature: Filter search results

  @141
  Scenario: Filter by 'Only' free shipping
    Given I visit main page
    When I search for "altın"
    And I store search result count
    And I apply a filter
    | Sadece | Kargo Bedava Ürünler |
    Then I should have a different result count


  @25 @reliable
  Scenario: Filter by 'Rating'
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I filter by rating
    Then I should only see products that fall under my preset range

  @28 @reliable
  Scenario: Filter by 'Brand'
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I filter by brand
    Then I should only see products that fall under my preset range

  @27
  Scenario: Filter by first level category
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I filter by first level category
    Then I should only see products that fall under my preset range

  @343
  Scenario: Filter by specific attribute
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I filter by case type
    Then I should only see products that fall under my preset range

  @65
  Scenario: Filter by super fast delivery
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I apply a filter
    | Sadece | Süper Hızlı Gönderidekiler |
    When I select a product from search results
#    Then I see the super fast delivery flag

  @23
  Scenario: Filter by price range
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I filter by price
    Then I should only see products that fall under my preset range

  @246
  Scenario: Clear active filters
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I filter by rating
    And   I filter by brand
    When I clear active filters
    Then I should see all results
    And I should not see any selected filters

  @246
  Scenario: Clear filters button inactive when no filters are active
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Then I cannot click the clear filters button

  @416
  Scenario: Canonical for Multiple filtered brands
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    Given I search for "TV"
    When I filter for LG
    And I filter for Samsung

  @259
  Scenario: Clearing an individual filter from the result page updates the results
    Given I am on the homepage
    When I search for "iPhone"
    And I can see the results
    And I should see all results
    And I filter for Ozaki
    And I filter for Muvit
    And I should only see products that fall under my preset range
    When I remove the filter for Ozaki
    When I remove the filter for Muvit
    Then I should see all results

  @253
  Scenario: Filtering results within subcategories (second to third, third to fourth levels)
    Given I visit main page
    And I search for "ayakkabı"
    When I select a sub category in search
    | Giyim / Ayakkabı | Erkek | Erkek Ayakkabı | Erkek Bot |
    Then There are some results available

  @229
  Scenario Outline: Filter by category
    Given I visit main page
    When I search for "<item>"
    And There are some results available
    Then Sub categories are displayed in filters section
    Examples:
    | item   |
    | kitap  |
    | defter |
    | kalem  |
    | saat   |
    | silgi  |

  @24
  Scenario: Filter by promotions in search results
    Given I visit main page
    When I search for "iphone"
    And I store search result count
    And I apply a filter
    | Sadece | Süper Hızlı Gönderidekiler |
    Then I should have a different result count

  @24
  Scenario: Filter by promotions in CLP
    Given I visit main page
    When I navigate to Category
    | Kitap, Müzik Film, Hobi | Müzik (Medya) |
    And I store search result count
    And I apply a filter
    | Sadece | İndirimli Ürünler |
    Then I should have a different result count

  @343
  Scenario: Specific filters should appear on search results
    Given I visit main page
    Given I search for "Michelin lastik"
    When I apply a filter
      | Jant Çapı       | 17    |
      | Kullanım Türü   | Binek |
      | Taban Genişliği | 225mm |
    Then There are some results available

  @343
  Scenario: Specific filters should appear on browsing results
    Given I visit main page
    And I navigate to Category
      | Süpermarket Petshop | Petshop |
    And I select a sub category in browsing
      | Kedi | Kedi Mamaları | Tümünü Gör |
    When I apply a filter
      | Yaş           | 1-7 Yaş  |
      | Ürün Kilogram | 10-15 kg |
    Then There are some results available

  @1192
  Scenario Outline: Check filter fields for more filters buttons in clps
    Given I visit main page
    When I navigate to Category
    | <cat1> | <cat2> |
    And There are some results available
    Then I don't see more filters buttons in filters
    Examples:
    | cat1                 | cat2           |
    | Elektronik           | Akıllı Telefon |
    | Giyim, Takı Aksesuar | Erkek          |

  @1192
  Scenario Outline: Check filter fields for more filters buttons in search results
    Given I visit main page
    When I search for "<item>"
    Then I don't see more filters buttons in filters
    Examples:
    | item     |
    | gömlek   |
    | ayakkabı |
