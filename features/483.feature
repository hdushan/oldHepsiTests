#encoding: UTF-8

Feature: 483 - Check campaign banners next to carousel
  As a browser
  I want to see campaing banners next to carousel
  So that i can easily see recent campaings

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

  Scenario: Check for 3 campaign banners on page
    Then There should be "2" banners next to carousel