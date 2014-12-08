#encoding: UTF-8
@storefront

Feature: Mobile Homepage is as expected
  As a researcher
  I want to navigate around the site
  So that I can navigate to products or find information relevant to me

  Background:
    Given I visit mobile main page

  @10 @inprogress
  Scenario: Clicking around Storefront
    Given I am at mobile main page
    When I click the Hepsiburada logo
    Then I should be redirected to mobile Homepage

  @10 @inprogress
  Scenario: Navigating back Storefront
    Given I am at mobile main page
    And I navigate to Mobile_Category
      | Spor Outdoor |
    And I select a sub category in browsing
      | Spor / Fitness | Spor Branşları | Tümünü Gör |
    When I click the Hepsiburada logo
    Then I should be redirected to mobile Homepage