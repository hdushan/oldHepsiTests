#encoding: UTF-8

Feature: 488 - Display tax included prices in
  As a customer
  I want to see KDV included prices for on sale products
  So that i can clearly see the total amount that i'm going to pay

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

    Scenario Outline: Check some products for their discounts
      Given I retrieve details from product service with id "<id>"
      When I search for the stored product
      And I open search result no "1"
      Then I am on product details
      And Discounted price is displayed correctly
      Examples:
      | id                |
      | OYUNSHI90050-K100 |
      | KTIMAS43484       |
      | SPORP355568091-28 |
      | BD802112          |
      | OFISDURMAXAAA62   |
