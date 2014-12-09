#encoding: UTF-8

Feature: 355 - Setting Cookie for "Go To Desktop" Link
  As a user
  I want to be able to go desktop page clicking link at the bottom of the mobile page.

  Scenario: Testing
    Given I visit mobile main page
    When I click go to desktop version link
    Then I am on old hepsiburada mainpage