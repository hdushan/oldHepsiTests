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

  @84
  Scenario: Display product reviews
    Given I select a product with SKU SPORALTISSD5000
    Then I see at least 3 reviews
    And I can see the 'More Reviews' button

  @78
  Scenario: Display returns policy
    Given I select a product with SKU TELCEPSAMN910-B
    And I see to link to view the returns policy
    When I click on the returns policy link
    Then I see the returns policy

  @73
  Scenario: Display product tech specs
    Given I select a product with SKU TELCEPSAMN910-B
    Then I can view the product tech specs

  @68
  Scenario: Display payment installment options with table-based information
    Given I select a product with SKU SPORALTISSD5000
    When I view the payment installments information
    Then I see at least one payment installment table

  @103
  Scenario: Display free shipping tag
    Given I select a product with SKU SGSBM8001
    Then I see text indicating that free shipping is available

  @103
  Scenario: No free shipping on details
    Given I select a product with SKU BD800476
    Then I don't see a text indicating that free shipping is available

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

  @330 @390 @632 @423
  Scenario: Clicking an Exposed Color Changes the Product Image
    Given I select a product with SKU AYKP38462CGBBZ37
    And I see the default product image 
    When I select the color Sarı
    And I wait for all Ajax requests to complete
    Then I see a different image
    And element with id Renk2 is selected

  @97
  Scenario: Bestseller section
    Given I select a product with SKU EAKSERELEKTBAT
    Then I should see the bestseller section

  @118
  Scenario: I can add a procurable item to basket
    Given I select a product with SKU EAKSERELEKTBAT
    Then I should see the quantity box with a default of 1

  @118 @flaky
  Scenario: I can add multiple items to basket at once
    Given I select a product with SKU EAKSERELEKTBAT
    Then I add "5" product(s) to cart

  @118 @flaky
  Scenario: I cannot add a negative quantity of items to basket
    Given I select a product with SKU EAKSERELEKTBAT
    And I enter a quantity of -1
    When I add to cart
    Then I should see an invalid message notification

  @139
  Scenario: I see the instalments on a valid product
    Given I select a product with SKU MTHOTARWMF903EU
    Then I should see the installments section

  @139
  Scenario: I should not see the installments section on an invalid product
    Given I select a product with SKU EAKSERELEKTBAT
    Then I should not see the installments section

  @94 @recommended_products_on_product_detail_page_enabled
  Scenario: Display suggested products when available and selecting a product takes me to the details page
    Given I select a product with SKU TELCEPSAMN9000-B
    Then I see a maximum of 10 products in the suggestions area
    And I see a picture associated with each product
    And when I select the first suggested product
    Then I am on product details

  @94
  Scenario: If the product has no suggestions, there should not be a section
    Given I select a product with SKU OUTFEY51113
    Then I do not see suggestions

  @323
  Scenario: Remove add to cart from product details when item is out of stock
    Given I visit main page
    When I search for "BD800472"
    And I open search result no "1"
    Then Add to cart button is not available on product details
#    And I am able to select different variants

  @319
  Scenario: Clicking through to a product
    Given I visit main page
    And I search for "yüzük"
    And There are some results available
    When I open search result no "2"
    Then I am on product details

  @318
  Scenario: Add to basket
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I search for "MTARCELIK6230BULAS"
    And I open search result no "1"
    And I am on product details
    When I add "1" product(s) to cart
    Then Cart icon should have an indication of "1"

  @318
  Scenario: Adding to basket without selecting a variant
    Given I visit main page
    And I search for "ZYPYON2897"
    When I open search result no "1"
    And I am on product details
    Then I should not be able to add to cart without a variant

  @318
  Scenario: Comments
    Given I visit main page
    And I search for "ZYPYON2897"
    And I open search result no "1"
    When I am on product details
    And There are "3" comments on details
    And I click on more comments button
    Then There are "6" comments on details

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

  @318
  Scenario: Clicking through technical specs
    Given I visit main page
    And I search for "ZYPYON2897"
    And I open search result no "1"
    And I am on product details
    When I click product specs tab
    Then I get the product specs

#  @726 @ignore
#  Scenario: see the timer on Deal of the Day product detail pages
#    Given I visit main page
#    And I open deal of the day no "1"
#    Then I see a timer on product details page that shows when the deal ends

  @83
  Scenario: Ratings of a product on details page
    Given I visit main page
    When I search for "TELCEPSAMN9000-B"
    And I open search result no "1"
    Then I am on product details
    And There are "3" comments on details
    And I see the number of reviews

  @83
  Scenario: No ratings
    Given I visit main page
    When I search for "TELKULSENN10109"
    And I open search result no "1"
    Then I am on product details
    And There are no comments on details

  @68
  Scenario: No installment
    Given I visit main page
    When I search for "TELCEPSAMN9000-B"
    And I open search result no "1"
    Then There is no installment option for this product

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

  @859
  Scenario: Top sellers on product details
    Given I visit main page
    When I search for "AILEBNDBL2401"
    And I open search result no "1"
    Then There is a top sellers section

   @726 @1095
   Scenario: See the timer on Deal of the Day product detail pages
     Given I visit main page
     When I search for "EVLG49UB820V"
     And I open search result no "1"
     Then I should see deal of the day counter in details

  @727 @1095
  Scenario: See stock left for Deal of the Day items
    Given I visit main page
    When I search for "EVLG49UB820V"
    And I open search result no "1"
    Then I should see stock left for deal of the day items for "EVLG49UB820V"

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

  @329
  Scenario: Anonymizing comments - male
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "male" person

  @329
  Scenario: Anonymizing comments - female
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "female" person

  @329
  Scenario: Adhering to the existing commenting structure
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "normal" person

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

  @984
  Scenario: View reviews through reviews tab
    Given I visit main page
    When I search for "anakart"
    And I open search result no "2"
    And I click reviews tab
    Then I see reviews tab

  @984
  Scenario: View reviews through reviews link
    Given I visit main page
    When I search for "EVDEMIRNITROMIXP24"
    And I open search result no "1"
    And I click reviews link on details
    Then I see reviews tab

  @984
  Scenario: View more reviews
    Given I visit main page
    And I search for "nokia asha 501"
    When I open search result no "1"
    And I click reviews tab
    Then There are "3" comments on details
    When I click on more comments button
    Then There are "6" comments on details
    When I click on more comments button
    Then There are "9" comments on details

  @984
  Scenario: Rate reviews as positive
    Given I visit main page
    And I search for "OTCTN115725"
    When I open search result no "1"
    And I click reviews link on details
    And I mark review no "1" as "positive"
    Then In comment no "1" some rating message appears
    When I refresh page
    And I click reviews tab
    And I mark review no "1" as "negative"
    Then In comment no "1" some rating message appears

  @984
  Scenario: Rate reviews as negative
    Given I visit main page
    And I search for "KCIZMELIKEDI53504"
    When I open search result no "1"
    And I click reviews link on details
    And I mark review no "1" as "negative"
    Then In comment no "1" some rating message appears
    When I refresh page
    And I click reviews tab
    And I mark review no "1" as "negative"
    Then In comment no "1" some rating message appears

  @984
  Scenario: See no reviews
    Given I visit main page
    When I search for "OUTSENI75507"
    And I open search result no "1"
    Then There is not a reviews link on details
    When I click reviews tab
    Then I see an empty reviews section

  @859
  Scenario Outline: See top sellers section on product details
    Given I visit main page
    When I search for "<item>"
    And I open search result no "1"
    Then There is a top sellers section
    Examples:
    | item |
    | K2HAYY25450 |
    | AILEBANEKSD110030 |
    | MTTEFFC22 |

  @93
  Scenario: Go to product details without any compatible products
    Given I visit main page
    And I search for "OUTBURC15395-1"
    And I open search result no "1"
    When I am on product details
    Then I do not see any compatible products

  @93
  Scenario: Go to product details with one group of compatible products
    Given I visit main page
    And I search for "BD730092"
    And I open search result no "1"
    When I click on compatible products tab
    Then I should see compatible products
    And There should be only one compatible product group

  @93
  Scenario: Go to product details with multiple groups of compatible products
    Given I visit main page
    And I search for "BD131818"
    And I open search result no "1"
    When I click on compatible products tab
    Then I should see compatible products
    And There should be multiple compatible product group

  @93 @merchant_disabled
  Scenario: Add to basket from compatible products
    Given I visit main page
    And I clear cart items
    And I visit main page
    And I search for "BD800104"
    And I open search result no "1"
    When I click on compatible products tab
    And I add compatible product no "3" to basket
    Then I see the cart item count is 1

  @93
  Scenario: Go to compatible products details
    Given I visit main page
    And I search for "BD730092"
    And I open search result no "1"
    When I click on compatible products tab
    Then All compatible products details should be accessible

  @1087
  Scenario: Totals text in top sellers should not be a link
    Given I visit main page
    And I search for "iphone"
    When I open search result no "1"
    Then Totals in topsellers section should not be a link

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

  @1015
  Scenario: Comment without login from description
    Given I visit main page
    And I search for "yemek kitabı"
    When I open search result no "1"
    And I click add comment from product description
    Then I should be redirected to login page

  @1015
  Scenario: Comment without login from comment tab
    Given I visit main page
    And I search for "yemek kitabı"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should be redirected to login page

  @1015
  Scenario: Validate Add Comment fields
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "bebek maması"
    When I open search result no "1"
    And I click add comment from product description
    Then Comment fields should appear as expected

  @1015
  Scenario: Check Mandatory Fields
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "bebek maması"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should not be able to submit without mandatory fields

  @1015
  Scenario: Check character limit
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "bebek maması"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should not be able to pass character limits

  @1015
  Scenario: Successful comment input
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "AILEMLP001001070"
    When I open search result no "1"
    And I click add comment from product description
    Then I add a comment with these values
    | header    | başlık                          |
    | review    | bu review ı yazan adam kör oldu |
    | rating    | 3 star                          |
    | show_name | Evet                            |
    And I get a message about successful comment adding
    And Admin approves added comment
      | header    | başlık                          |
      | review    | bu review ı yazan adam kör oldu |
      | sku       | AILEMLP001001070                |
    And I see the approved comment on the product detail
      | header    | başlık                          |
      | review    | bu review ı yazan adam kör oldu |
      | rating    | 3 star                          |
      | name      | test user                       |
    And I delete comment from db
    | header    | başlık                          |
    | review    | bu review ı yazan adam kör oldu |
    | sku       | AILEMLP001001070                |







