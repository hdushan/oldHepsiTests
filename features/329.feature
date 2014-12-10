#encoding: UTF-8

Feature: 329 - Anonymize Comments with Gender Names for Privacy of Customer
  As a Hepsiburada customer
  I want to hide my name in the comments
  So that I can honestly share my feelings about a product with my privacy respected

  Scenario: Anonymizing comments - male
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "male" person

  Scenario: Anonymizing comments - female
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "female" person

  Scenario: Adhering to the existing commenting structure
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "normal" person