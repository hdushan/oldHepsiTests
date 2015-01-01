#encoding: UTF-8
@storefront @reliable

Feature: Feedback mechanism for beta
  As a product owner
  I want to gather feedback from users about my new website
  So that I can measure my new websites performance

  @481
  Scenario: Open feedback window
    Given I am on the homepage
    When I click the feedback button
    Then I see a feedback window