#encoding: UTF-8
Feature: 481 - User should have a way to give feedback
  As a product owner
  I want to gather feedbacks from users about my new website
  So that i can measure my new websites performance

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

  Scenario: Check for feedback button on homepage
    When There is a feedback button on current page
    Then I should be able to give feedback

  Scenario: Check for feedback button on CLP
    Given I navigate to Category
    | Anne, Bebek Oyuncak | Bebek Güvenlik |
    When There is a feedback button on current page
    Then I should be able to give feedback

  Scenario: Check for feedback button on product details page
    Given I search for "SGBABYLISS087307"
    When There is a feedback button on current page
    Then I should be able to give feedback