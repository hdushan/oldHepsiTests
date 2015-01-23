#encoding: UTF-8
@storefront @product
Feature: Add reviews
  As a Hepsiburada site admin
  I want users to be asked to fill in certain mandatory fields
  So that I can avoid meaningless comments

  @1015
  Scenario: Check Mandatory Fields
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "bebek maması"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should not be able to submit without mandatory fields
    And I log out

  @1015
  Scenario: Check character limit
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "bebek maması"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should not be able to pass character limits
    And I log out