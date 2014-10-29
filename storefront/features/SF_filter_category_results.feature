@storefront
Feature: Filter category results
  
  Background:
    Given I am on the homepage
    And I visit the telephones category page
    
  @343
  Scenario: Filter by specific attribute
    When I filter by material type
    Then I should only see products that fall under my preset range
