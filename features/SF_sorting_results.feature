#encoding: UTF-8
@storefront
Feature: Sorting Search Results

  @31
  Scenario: Sort by bestseller
    Given I am on the homepage
    And I search for "cd"
    When I sort by bestseller
    Then I see the bestseller button is selected

  @31
  Scenario: Reload page after sorting by bestseller
    Given I am on the homepage
    And I search for "cd"
    When I sort by bestseller
    And I reload the page
    Then I see the bestseller button is selected

  @31
  Scenario: Sort by bestseller and load more results
    Given I am on the homepage
    And I search for "cd"
    When I sort by bestseller
    And I click load more results
    Then I see the bestseller button is selected

  @31 @flaky
  Scenario: Change sort mode
    Given I am on the homepage
    And I search for "cd"
    Given I sort by bestseller
    When I sort by lowest price
    Then I see the bestseller button is not selected
    And I see the lowest price button is selected

  @26
  Scenario: Default sort mode
    Given I am on the homepage
    And I search for "cd"
    Then I see the best matching button is selected

  @26
  Scenario: Sort by lowest price
    Given I am on the homepage
    And I search for "cd"
    When I sort by lowest price
    Then I see the lowest price button is selected
    And I see results lowest price first

  @26 @flaky
  Scenario: Sort by highest price
    Given I am on the homepage
    And I search for "cd"
    When I sort by highest price
    Then I see the highest price button is selected
    And I see results highest price first

  @26
  Scenario: View more results preserves sort
    Given I am on the homepage
    And I search for "cd"
    Given I sort by lowest price
    When I click load more results
    Then I should see 40 visible results
    And I see results lowest price first

  @23
  Scenario: Clicking more results
    Given I visit main page
    When I search for "kedi maması"
    And I apply a filter
    | Fiyat Aralığı | 0 TL - 25 TL |
    Then I click load more results
    And There are "40" results displayed

  @23
  Scenario: Sorting the results ascending
    Given I visit main page
    When I search for "kedi maması"
    And I apply a filter
      | Fiyat Aralığı | 0 TL - 25 TL |
    And I sort by lowest price
    Then I see results lowest price first

  @23
  Scenario: Clicking more results descending
    Given I visit main page
    When I search for "kedi maması"
    And I apply a filter
      | Fiyat Aralığı | 0 TL - 25 TL |
    And I sort by highest price
    Then I see results highest price first

