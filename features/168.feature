#encoding: UTF-8

Feature: 168 - Calculate and Show Price for Gold Properly
  As a Hepsiburada customer
  I want to see the price of gold as I would any other item
  So that I have a consistent shopping experience.

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

  Scenario: Search for gold
    Given I search for "çeyrek altın"
    And I see the price on search item no "3"
    When I open search result no "3"
    Then price is listed correctly in details

  Scenario: Browse to gold category
    Given I navigate to Category
    | Giyim, Takı Aksesuar | Altın/Takı/Mücevher |
    And I click breadcrumb "Altın / Takı / Mücevher"
    And I select a sub category in browsing
    | Külçe, Ziynet, Cumhuriyet Altını | Tümünü Gör |
    And I see the price on search item no "2"
    When I open search result no "2"
    Then price is listed correctly in details