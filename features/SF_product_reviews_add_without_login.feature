#encoding: UTF-8
@storefront @product
Feature: Add reviews
  As a Hepsiburada site admin
  I want users to be asked to login before commenting
  So that I can avoid spam comments

  @1015
  Scenario: Comment without login from description
    Given I visit main page
    And I search for "yemek kitabı"
    When I open search result no "1"
    And I click add comment from product description
    Then I should be redirected to login page

  @1015
  Scenario: Comment without login from comment tab
    Given I visit main page
    And I search for "yemek kitabı"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should be redirected to login page