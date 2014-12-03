#encoding: UTF-8

  Feature: I should see breadcrums in search engine optimisation tools
    As a SEO manager
    I want breadcrumb information to be visible as part of search engine microdata
    So that I maximise Hepsiburada’s crawlability

    Scenario: Go to main page
      Given I visit main page
      Then I am at main page

    Scenario: Go to product details page for viewing breadcrums
      Given I search for "EAKMETGM153-90190"
      When I open search result no "1"
      Then I am on product details
      And I store breadcrumbs

    Scenario: Check if breadcrumbs are properly displayed in Structured Data Tool
      Then breadcrumbs should be available on google webtools
