@storefront

Feature: Remove filters from results

  Background:
    Given I am on the homepage
    And I search for book

  @246
  Scenario: Clear active filters
    Given I filter by rating
    And   I filter by brand
    When I clear active filters
    Then I see all results

  @246
  Scenario: Clear filters button inactive when no filters are active
    Then I cannot click the clear filters button