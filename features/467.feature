#encoding: UTF-8

Feature: 467 - Original prices should be displayed in deal of the day
  As a researcher
  I want to see undiscounted price of deal of the day products
  So that i can make a quick decision

  Scenario: Check for original prices on deal of the day carousel
    Given I visit main page
    And I am at main page
    When There are some items in deal of the day carousel
    Then Original prices should be displayed in deal of the day items


