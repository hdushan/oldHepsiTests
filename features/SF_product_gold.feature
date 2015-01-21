#encoding: UTF-8
@storefront @product
Feature: Product page for Gold
  As a buyer
  I want to be able to see things on the product page for Gold
  So that I can decide on whether to purchase the item

  @168
  Scenario: Search for gold
    Given I visit main page
    And I search for "çeyrek altın"
    And I see the price on search item no "3"
    When I open search result no "3"
    Then price is listed correctly in details

  @168
  Scenario: Browse to gold category
    Given I visit main page
    And I navigate to Category
      | Giyim, Takı Aksesuar | Altın/Takı/Mücevher |
    And I click breadcrumb "Altın / Takı / Mücevher"
    And I select a sub category in browsing
      | Külçe, Ziynet, Cumhuriyet Altını | Tümünü Gör |
    And I see the price on search item no "2"
    When I open search result no "2"
    Then price is listed correctly in details