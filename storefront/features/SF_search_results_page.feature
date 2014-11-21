@storefront
Feature: Search page is as expected
  As a buyer
  I want to be able to search for things
  So that I can find the item I am looking for

  Background:
    Given I am on the homepage
    When I search for Samsung

  @143 @18
  Scenario: Display product prices
    Then I see either a price or an unavailable statement for each result

  @19
  Scenario: Display product images
    Then I see a product image for each result

  @17
  Scenario: View results page
    Then I should see 20 visible results

  @17
  Scenario: Clicking more results
    When I click load more results
    Then I should see 40 visible results

  @429
  Scenario: Do not show breadcrumb trail when searching or filtering
    Then I do not see a breadcrumb trail


