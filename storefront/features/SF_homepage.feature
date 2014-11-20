# encoding: UTF-8

@storefront
Feature: Homepage is as expected
  As a buyer
  I want to be able to see things on the homepage
  So that I can navigate the site to purchase items

  Background:
    Given I am on the homepage

  @190 @467
  Scenario: Show "Deal of the Day" on Homepage
    Then I see 6 items in deal of the day
    And each deal of the day product shows its undiscounted price

  @248
  Scenario: Show social icons in footer
    Then I see the social icons in the footer

  @248
  Scenario: Show security logo in footer
    Then I see the security logo in the footer

  @248
  Scenario: Show copyright in the footer
    Then I see the copyright message in the footer

  @16
  Scenario: Searching, with results
    When I search for iPhone
    Then I should see a list of iPhone results

  @16
  Scenario: Searching, with no results
    When I search for iPhonethatdoesnotexist
    Then I should see no results page

  @523
  Scenario: Viewing the fly-out menu
    Given I hover over the electronic appliances navigation bar entry
    Then I see the fly-out menu

  @189
  Scenario: View the static banners
    Then I can see at least 2 static banners

  @466
  Scenario: Checking banner size
    Then I see banners of size 900x370
