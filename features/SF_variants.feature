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

    @700
    Scenario Outline: Different variants of the product should have different discount values
      Given I visit main page
      And I search for "EAKSAN1MP-VP80V0"
      And I open search result no "1"
      And I am on product details
      When I change the variant to "<variant>"
      Then The discount is "<discount>" percent on details
    Examples:
      | variant  | discount |
      | 90x190   | 72       |
      | 90x200   | 72       |
      | 140x190  | 67       |
      | 150x200  | 66       |
      | 160x200  | 69       |

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

    @144
  Scenario: Display variants with price on the details page
    Given I select a product with SKU TELCEPHTCM8-G
    Then I see the option to select a variant with prices
    And I see no variant with prices is selected
    When I add to cart
    Then I see an error message asking me to make a selection

  @144
  Scenario: Select variant on results page
    Given I select a product with SKU TELCEPNOKLU620-B
    When I select the first variant with price
    Then I see the the variant with price is checked

  @330 @390 @632 @423
  Scenario: Clicking an Exposed Color Changes the Product Image
    Given I select a product with SKU AYKP38462CGBBZ37
    And I see the default product image
    When I select the color Sarı
    And I wait for all Ajax requests to complete
    Then I see a different image
    And element with id Renk2 is selected