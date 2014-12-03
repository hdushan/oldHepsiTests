#encoding: UTF-8

  Feature: I should see breadcrums in search engine optimisation tools
    As a SEO manager
    I want breadcrumb information to be visible as part of search engine microdata
    So that I maximise Hepsiburada’s crawlability

    Scenario: Go to main page
      Given I visit main page
      Then I am at main page

    Scenario: Go to product details page for viewing breadcrumbs and check them in GWT
      Given I search for "EAKMETGM153-90190"
      When I open search result no "1"
      And I store breadcrumbs
      Then breadcrumbs should be available on google webtools

    Scenario Outline: Go to catalog landing pages and check the breadcrumbs in GWT
      Given I visit main page
      When I navigate to Category
      | <cat1> | <cat2> |
      And I store breadcrumbs
      Then breadcrumbs should be available on google webtools
      Examples:
      | cat1                   | cat2                  |
      | Kozmetik Kişisel Bakım | Duş ve Banyo Ürünleri |
      | Spor Outdoor           | Spor Branşları        |
      | Ev, Yaşam Ofis         | Ev Tekstili           |


