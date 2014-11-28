@storefront

Feature: Filter search results

  Background:
    Given I am on the homepage
    When I search for iPhone
    And I can see the results

  @141
  Scenario: Filter by 'Only'
    Given I filter by shipping style
    Then I should only see products that fall under my preset range

  @25 @83
  Scenario: Filter by 'Rating'
    Given I filter by rating
    Then I should only see products that fall under my preset range
    And I see ratings for all products

  @28
  Scenario: Filter by 'Brand'
    Given I filter by brand
    Then I should only see products that fall under my preset range

  @27
  Scenario: Filter by first level category
    Given I filter by first level category
    Then I should only see products that fall under my preset range

  @343
  Scenario: Filter by specific attribute
    Given I filter by case type
    Then I should only see products that fall under my preset range

  @65
  Scenario: Filter by super fast delivery
    Given I filter by super fast delivery
    When I select a product from search results
    Then I see the super fast delivery flag

  @23
  Scenario: Filter by price range
    Given I filter by price
    Then I should only see products that fall under my preset range

  @246
  Scenario: Clear active filters
    Given I filter by rating
    And   I filter by brand
    When I clear active filters
    Then I should see all results
    And I should not see any selected filters

  @246
  Scenario: Clear filters button inactive when no filters are active
    Then I cannot click the clear filters button

  @416
  Scenario: Canonical for Multiple filtered brands
    Given I search for TV
    When I filter by the brand LG
    And I filter by the brand Samsung