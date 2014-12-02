#encoding: UTF-8

Feature: Discounts and top sellers not shown on category landing pages

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

  Scenario: Open a product detail
    Given I search for "EAKMETGM153-90190"
    When I open search result no "1"
    Then I am on product details
    And The discount is "61" percent on details

  Scenario Outline: Different variants of the product should have different discount values
    Given I am on product details
    When I change the variant to "<variant>"
    Then The discount is "<discount>" percent on details
    Examples:
    | variant  | discount |
    | 90x190   | 61       |
    | 90x200   | 59       |
    | 140x190  | 39       |
    | 150x200  | 41       |
    | 160x200  | 34       |