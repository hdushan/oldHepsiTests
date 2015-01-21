#encoding: UTF-8
@storefront @product
Feature: Product page is as expected
  As a buyer
  I want to be able to see things on the product page
  So that I can decide on whether to purchase the item

  @143 @19 @62
  Scenario: Display Product information
    Given I select a product with SKU TELCEPSAMN910-B
    Then I see the product information

  @78
  Scenario: Display returns policy
    Given I select a product with SKU TELCEPSAMN910-B
    And I see to link to view the returns policy
    When I click on the returns policy link
    Then I see the returns policy

  @103
  Scenario: Display free shipping tag
    Given I select a product with SKU SGSBM8001
    Then I see text indicating that free shipping is available

  @103
  Scenario: No free shipping on details
    Given I select a product with SKU BD800476
    Then I don't see a text indicating that free shipping is available

  @138
  Scenario: Display original price on details page for discounted product
    Given I select a product with SKU SGCK0560740
    Then I see the original price 167,01 TL on the product details page
    And I see the discount percentage of 64

  @138
  Scenario:Do not display original price on details page for non discounted product
    Given I select a product with SKU TELCEPIP6P16GBGO-N
    Then I do not see a discount price

  @138
  Scenario: Display original price on search page
    Given I search for "SGCK0560740"
    Then I see the original price 59,90 TL on the product with sku SGCK0560740

  @140
  Scenario: Display non-generic returns policy for DVD
    Given I select a product with SKU DVDEMI249
    When I click on the returns policy link
    Then I see product return information specific to media

  @319
  Scenario: Clicking through to a product
    Given I visit main page
    And I search for "yüzük"
    And There are some results available
    When I open search result no "2"
    Then I am on product details

  @318
  Scenario: The return policy
    Given I visit main page
    And I search for "ZYPYON2897"
    And I open search result no "1"
    And I am on product details
    When I click return policy link
    Then I get the return policy description

  @318
  Scenario: Clicking through description
    Given I visit main page
    And I search for "ZYPYON2897"
    And I open search result no "1"
    And I am on product details
    When I click product description tab
    Then I get the product description

#  @726 @ignore
#  Scenario: see the timer on Deal of the Day product detail pages
#    Given I visit main page
#    And I open deal of the day no "1"
#    Then I see a timer on product details page that shows when the deal ends

  @65
  Scenario: Open details for an item which doesn't have super fast shipping
    Given I visit main page
    When I search for "KTIMAS43484"
    And I open search result no "1"
    Then I don't see the super fast delivery flag

  @61
  Scenario: Search result image should exist in product details
    Given I visit main page
    When I search for "BD800476"
    And Store image name on search result no "1"
    And I open search result no "1"
    Then I should see the stored image in product details
    
  @60
  Scenario: Cycle through images in an item that has multiple images
    Given I visit main page
    When I search for "BD800476"
    And I open search result no "1"
    Then There are multiple images in details
    And I cycle through thumbnails in details

  @60
  Scenario: See one image in product details
    Given I visit main page
    When I search for "OUTPA80156"
    And I open search result no "1"
    Then There is only one image in details

  @56
  Scenario: Product title should be included in details page
    Given I visit main page
    And I search for "PTTROPP-1710"
    When I open search result no "1"
    Then Product title is displayed in details

  @56
  Scenario: Product sku should be included in url
    Given I visit main page
    And I search for "PTTROPP-1710"
    When I open search result no "1"
    Then Product sku is contained in the url

  @488
  Scenario Outline: Check some products for their discounts
    Given I visit main page
    And I retrieve details from product service with id "<id>"
    When I search for the stored product
    And I open search result no "1"
    Then I am on product details
    And Discounted price is displayed correctly
  Examples:
    | id                 |
    | OYUNRUBVTCH79808   |
    | EVPHGC3560         |
    | FTHFZSAN16GMCAND48 |
    | BD802112           |
    | MTSINSJ3137        |

  @700
  Scenario: Open a product detail
    Given I visit main page
    And I search for "EAKSAN1MP-VP80V0"
    When I open search result no "1"
    Then I am on product details
    And The discount is "79" percent on details

  @1021
  Scenario: Go to product return policy with product a
    Given I visit main page
    When I search for "EVLG42UB820V"
    And I open search result no "1"
    Then The return policy has text type one

  @1021
  Scenario: Go to product return policy with product b
    Given I visit main page
    When I search for "oyunsindno5"
    And I open search result no "1"
    Then The return policy has text type two

  @1021
  Scenario: Go to product return policy with product c
    Given I visit main page
    When I search for "mbmettgm068"
    And I open search result no "1"
    Then The return policy has text type three

  @970
  Scenario Outline: Check product details for delivery time badges
    Given I visit main page
    And I search for "<sku>"
    When I open search result no "1"
    Then I see delivery time as "<time>"
    Examples:
    | sku | time |
    | OFISALPROOSMASA2 | 2-3 Hafta |
    | MBK105SZR1207    | 1-2 Hafta |
    | HRFELCO9         | 6 Gün     |
    | OUTFALFA2021     | 4 Gün     |
    | HRTASARIM70      | 3 Gün     |
    | HRFID761         | 2 Gün     |
    | HRFID714         | 1 Gün     |
    | HRFELCO30        | 24 Saat   |

  @723
  Scenario: I should be able to see campaign badges in product details
    Given I visit main page
    When I search for "TELCEPIPH616GBSI-N"
    And I open search result no "1"
    Then I should see badges for the product "TELCEPIPH616GBSI-N"
