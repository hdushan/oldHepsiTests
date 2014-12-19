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
    And I see ratings for all products

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
    Then I see the super fast delivery flag

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