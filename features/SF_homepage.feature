# encoding: UTF-8

@storefront
Feature: Homepage is as expected
  As a buyer
  I want to be able to see things on the homepage
  So that I can navigate the site to purchase items

  Background:
    Given I am on the homepage
    And I clear the browsers cookies

  @190 @467 @ignore
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
    When I search for "iPhone"
    Then I should see a list of iPhone results

  @16
  Scenario: Searching, with no results
    When I search for "iPhonethatdoesnotexist"
    Then I should see no results page

  @523
  Scenario: Viewing the fly-out menu
    Given I hover over the electronic appliances navigation bar entry
    Then I see the fly-out menu

  @189
  Scenario: View the static banners
    Then I can see at least 2 static banners

  @466 @inprogress
  Scenario: Checking banner size
    Then I see banners with a width of 900 and a height of 370

  @466
  Scenario: Browsing through banners with thumbnails
    Given I click on the first banner thumbnail
    And I see the first banner
    When I click on the second thumbnail
    Then I see a different banner

  @466
  Scenario: Clicking on banners leads to a new page
    When I click on the current banner
    Then I am no longer on the homepage

  @33
  Scenario: Searching with one character does not produce suggestions
    Given I have input s into search
    Then I see no suggestions based on my inputs

  @33
  Scenario: Searching with at least two characters begins producing suggestions
    Given I have input sa into search
    And I see the auto complete suggestions
    Then I see suggestions based on sa
    And I see 3 categories and 10 other keywords

  @33
  Scenario: Search suggestions update as user enters in more or less into search
    Given I have input sa into search
    And I see the auto complete suggestions
    And I see suggestions based on sa
    When I append m into search
    And I wait for auto complete results to update
    Then I see suggestions based on sam

  @33
  Scenario: Ability to navigate through search suggestions
    Given I have input sa into search
    And I see the auto complete suggestions
    And I see no visual indication of auto complete selection
    When I press the down arrow
    Then I see a visual indication that an auto complete suggestion is selected

  @33
  Scenario: Selecting a search suggestion takes me to the corresponding search results
    Given I have input samsung into search
    And I see the auto complete suggestions
    And I see suggestions based on samsung
    When I click on the first search suggestion
    Then I see products relating to samsung

  @33
  Scenario: Searching without selecting a suggestion
    Given I have input samsung into search
    And I do not like any of the auto complete suggestions
    When I invoke search on my own keywords
    Then I see products relating to samsung