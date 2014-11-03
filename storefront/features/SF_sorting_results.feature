@storefront
@212
Feature: Sorting Search Results

  Background:
    Given I am on the homepage
    And I search for cd

  @31
  Scenario: Sort by bestseller
    When I sort by bestseller
    Then I see the bestseller button is selected

  @31
  Scenario: Reload page after sorting by bestseller
    When I sort by bestseller
    And I reload the page
    Then I see the bestseller button is selected

  @31
  Scenario: Sort by bestseller and load more results
    When I sort by bestseller
    And I click load more results
    Then I see the bestseller button is selected

  @31
  Scenario: Change sort mode
    Given I sort by bestseller
    When I sort by lowest price
    Then I see the bestseller button is not selected
    And I see the lowest price button is selected

  @26
  Scenario: Default sort mode
    Then I see the best matching button is selected

  @26
  Scenario: Sort by lowest price
    When I sort by lowest price
    Then I see the lowest price button is selected
    And I see results lowest price first

  @26
  Scenario: Sort by highest
    When I sort by highest price
    Then I see the highest price button is selected
    And I see results highest price first

  @26
  Scenario: View more results preserves sort
    Given I sort by lowest price
    When I click load more results
    Then I should see 40 visible results
    And I see results lowest price first

