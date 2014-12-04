#encoding: UTF-8
  Feature: Discounts and top sellers not shown on category landing pages

    @discounts_and_topsellers_disabled
    Scenario: Go to main page
      Given I visit main page
      Then I am at main page

    Scenario Outline: Hide discount an top seller fields if they are disabled
      Given I navigate to Category
        | <cat1> | <cat2> |
      When I am on results page
      Then There are some results available
      And Top sellers an discount items are not visible
      Examples:
      | cat1         | cat2           |
      | Spor Outdoor | Spor Branşları |
      | Oto, Bahçe   | Banyo          |