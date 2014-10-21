@27 @storefront

Feature: Filter by 1st level category
  As a researcher
  I want filter by first level categories
  So that I only see category-relevant products

  Background:
    Given I am on the homepage
    When I searched for iphone

    Scenario: Filter by first level category
      Given I filter by first level category
      Then I should only see products that fall under my preset range