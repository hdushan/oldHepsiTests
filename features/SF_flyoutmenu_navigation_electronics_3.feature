#encoding: UTF-8
  Feature: Test category contents

  @448  @326
  Scenario: Hover an menu items and check content
  Given I visit main page
  When I hover on menu item "Elektronik"
  Then There are items in the menu content
  When I store links from this menu item
  Then I visit these links 201 to 350 without an error page