#encoding: UTF-8


  Feature: 739 - Discounts and top sellers not shown on mobile category landing pages

    @mobile_discounts_and_topsellers_disabled
    Scenario: Go to mobile main page
      Given I visit mobile main page
      Then I am at mobile main page

    Scenario: Hide discount and top seller fields if they are disabled for Spor Outdoor
      Given I navigate to Mobile_Category
        | Spor Outdoor |
      When I select a sub category in browsing
        | Spor / Fitness | Spor Branşları | Tümünü Gör |
      Then There are some results available
      And Top sellers an discount items are not visible

    Scenario: Go to mobile main page
      Given I visit mobile main page
      Then I am at mobile main page

    @flaky
    Scenario: Hide discount and top seller fields if they are disabled for Telefon
      Given I navigate to Mobile_Category
        | Telefon |
      When I select a sub category in browsing
        | Cep Telefonu ve SmartPhone | Tümünü Gör |
      Then There are some results available
      And Top sellers an discount items are not visible
