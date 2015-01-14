#encoding: UTF-8
Feature: Test category contents

  @448
  Scenario Outline: Hover an menu items and check content
    Given I visit main page
    When I hover on menu item "<item>"
    Then There are items in the menu content
  Examples:
    | item                    |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |

  @448
  Scenario Outline: Hover an menu items and visit content
    Given I visit main page
    And I hover on menu item "<item>"
    When I store links from this menu item
    Then I visit these links without an error page
  Examples:
    | item                    |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |
