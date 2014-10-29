@storefront

Feature: Filter search results

  Background:
    Given I am on the homepage
    When I search for iPhone

  @141
  Scenario: Filter by 'Only'
    Given I filter by shipping style
    Then I should only see products that fall under my preset range

  @25
  Scenario: Filter by 'Rating'
    Given I filter by rating
    Then I should only see products that fall under my preset range

  @28
  Scenario: Filter by 'Brand'
    Given I filter by brand
    Then I should only see products that fall under my preset range

  @27
  Scenario: Filter by first level category
    Given I filter by first level category
    Then I should only see products that fall under my preset range

  @23
  Scenario: Filter by price range
    Given I filter by price
    Then I should only see products that fall under my preset range