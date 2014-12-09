#encoding: UTF-8
@merchant_disabled
Feature: 359 - Handling All 404 Pages Properly on Storefront
  As a QA
  I want all 404 pages on storefront to be handled properly
  So that we can have a reliable site without any 404s

  Scenario: Google a hepsiburada item and open it
    Given I make a google search with "hepsiburada sony playstation"
    When I click on google result no "1"
    Then I don't get the error page

  Scenario: Clicking header on checkout
    Given I visit main page
    When I go to checkout
    And I click on logo
    Then I don't get the error page

  Scenario: Return 404 http status on not found product page
    When I visit link "/bunjee-pure-3-kapili-1-cekmeceli-gardirop-p-MBNAYG3KAPI3551CEK"
    Then I get error page

  Scenario: Return 404 http status on not found category page
    When I visit link "/liste/department.aspx?categoryid=250006687678094&m_redir=0"
    Then I get error page
