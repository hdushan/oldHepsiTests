#encoding: UTF-8

Feature: 466 - Using Carousel Images for Desktop
  As a researcher
  I want to check featured banners on homepage
  So that i can make a quick comparision of featured products/campaigns

  Scenario: Clicking Through Banners
    Given I visit main page
    And I am at main page
    When There are items in carousel
    Then I should cycle through all of them and visit links