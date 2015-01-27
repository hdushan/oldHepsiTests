#encoding: UTF-8
Feature: Test category contents

  @448  @326
  Scenario Outline: Hover an menu items and check content
    Given I visit main page
    When I hover on menu item "<item>"
    Then There are items in the menu content
    When I store links from this menu item
    Then I visit these links without an error page
  Examples:
    | item                    |
    | Kitap, Müzik Film, Hobi |
    | Giyim, Takı Aksesuar    |