#encoding: UTF-8
  @variants
  Feature: View and select variants
    As a customer
    I would like to view and select variants of a product
    In order to purchase the product I want

  Scenario: Select variants with selection boxes only
    Given I visit main page
    When I search for "OUTHZTTPVFOT-03"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "2" select box variant groups
    And I should be able to cycle through variants

  Scenario: Select variants with only dropdowns
    Given I visit main page
    When I search for "AILEABC941"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "2" dropdown variant groups
    And I should be able to cycle through variants

  Scenario: Select variants with dropdowns and select boxes
    Given I visit main page
    When I search for "GYPI23RL16BEM"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "1" select box variant groups
    And There are "1" dropdown variant groups
    And I should be able to cycle through variants

  Scenario: Select variants with only radio buttons
    Given I visit main page
    When I search for "EAKSAN1MP-VP80V0"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "1" radio button variant groups
    And I should be able to cycle through variants

  Scenario: Select variants with radio buttons and dropdown
    Given I visit main page
    When I search for "AILENUK725459M"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "1" radio button variant groups
    And There are "1" dropdown variant groups
    And I should be able to cycle through variants

  Scenario: Select variants with radio buttons and select boxes
    Given I visit main page
    When I search for "AILEBABYJEMBJ01785"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "1" radio button variant groups
    And There are "1" select box variant groups
    And I should be able to cycle through variants

  Scenario: Select variants which are not size/color/number
    Given I visit main page
    When I search for "ZYPYON400538462"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "1" dropdown variant groups
    And I should be able to cycle through variants

  Scenario: Check if unprocurable variants are exposed
    Given I visit main page
    When I search for "GYPI23RL16BEM"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "1" dropdown variant groups
    And There are "1" select box variant groups
    And I should be able to cycle through variants having unprocurables exposed

  Scenario: Check if unprocurable variants are exposed in price field
    Given I visit main page
    When I search for "TELCEPNOKLU620-B"
    And There is an indication on search result no "1" about variants
    And I open search result no "1"
    Then There are "1" radio button variant groups
    And I should be able to cycle through variants having unprocurables exposed

  Scenario: Unprocurable items should not be added to basket
    Given I visit main page
    When I search for "GYPI23C134KIYL"
    And I open search result no "1"
    And I select a variant
    | box | renk | kirmizi-yesil-ekose |
    | box | beden| xl |
    Then I should not be able to add to cart without a variant

  @847
  Scenario Outline: See variants as thumbnails
    Given I visit main page
    And I search for "<item>"
    When I open search result no "1"
    Then There are variants displayed as thumbnails
    Examples:
    | item |
    | GYPI23R425BSES  |
    | GYPI22S5S66BMCL |
    | GYPI23C134KIYL  |