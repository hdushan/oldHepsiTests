#encoding: UTF-8
@storefront @product
Feature: Product page is as expected
  As a buyer
  I want to be able to see things on the product page
  So that I can decide on whether to purchase the item

  @143 @60 @19 @61 @62 @83
  Scenario: Display Product information
    Given I select a product with SKU TELCEPNOKLU925-B
    Then I see the product information

  @56
  Scenario: Page title contains product name
    Given I select a product with SKU TELCEPNOKLU925-B
    Then the page title contains the product name

  @84
  Scenario: Display product reviews
    Given I select a product with SKU TELCEPNOKLU925-B
    Then I see at least 3 reviews
    And I can see the 'More Reviews' button

  @78
  Scenario: Display returns policy
    Given I select a product with SKU TELCEPNOKLU925-B
    And I see to link to view the returns policy
    When I click on the returns policy link
    Then I see the returns policy

  @73
  Scenario: Display product tech specs
    Given I select a product with SKU TELCEPNOKLU925-B
    Then I can view the product tech specs

  @68
  Scenario: Display payment installment options with table-based information
    Given I select a product with SKU SPORALTISSD5000
    When I view the payment installments information
    Then I see at least one payment installment table

  @103
  Scenario: Display free shipping tag
    Given I select a product with SKU SPORALTISSD5000
    Then I see text indicating that free shipping is available
    Then I see the returns policy

  @103
  Scenario: No free shipping on details
    Given I select a product with SKU BD800476
    Then I don't see a text indicating that free shipping is available

  @144
  Scenario: Display variants with price on the details page
    Given I select a product with SKU TELCEPSAMI8200-B
    Then I see the option to select a variant with prices
    And I see no variant with prices is selected
    When I add to cart
    Then I see an error message asking me to make a selection

  @144
  Scenario: Select variant on results page
    Given I select a product with SKU TELCEPSAMI8200-B
    When I select the first variant with price
    Then I see the the variant with price is checked

  @301
  Scenario: Display variants on details page for multi-variant product
    Given I select a product with SKU GYPI22R5R14AMAM
    Then there are 2 variants displayed
    And the variants should have no default

  @138
  Scenario: Display original price on details page for discounted product
    Given I select a product with SKU KIMGE033
    Then I see the original price 6,30 TL on the product details page
    And I see the discount percentage of 11

  @138
  Scenario:Do not display original price on details page for non discounted product
    Given I select a product with SKU TELCEPIP6P16GBGO-N
    Then I do not see a discount price

  @138
  Scenario: Display original price on search page
    Given I search for "KIMGE033"
    Then I see the original price 6,30 TL on the product with sku KIMGE033

  @140
  Scenario: Display non-generic returns policy for DVD
    Given I select a product with SKU DVDEMI249
    When I click on the returns policy link
    Then I see product return information specific to media

  @330
  Scenario: Expose Color Variants as Thumbnails on Details Page
    Given I select a product with SKU AYKP38462CGBBZ37
    Then I should see 3 color variants

  @330
  Scenario: Expose One Color Variant as Thumbnail on Details Page
    Given I select a product with SKU AYKIT5KITA0008BO36
    Then I should see 1 color variants

  @330 @390 @632 @423
  Scenario: Clicking an Exposed Color Changes the Product Image
    Given I select a product with SKU AYKP38462CGBBZ37
    And I see the default product image 
    When I select the color Sarı
    And I wait for all Ajax requests to complete
    Then I see a different image
    And element with id Renk2 is selected

  @658
  Scenario: Window resize
    Given I select a product with SKU TELCEPIP6P16GBGO-N
    When I make the page half as wide
    Then I see no horizontal scroll bar

  @658
  Scenario: low resolution monitor
    Given I select a product with SKU TELCEPIP6P16GBGO-N
    When I load the page on a 1280x1024 monitor
    Then I see no horizontal scroll bar

  @390 @632
  Scenario: Change the value of a dropdown box
    Given I select a product with SKU OUTOP001200S
    When I select the value XL from the v-beden dropdown
    Then I see XL in the v-beden dropdown box

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
    And I enter a quantity of 5
    When I add to cart
    Then I should see a notification of 5 items added to my basket

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
    Given I select a product with SKU BD601126-B
    Then I see a maximum of 10 products in the suggestions area
    And I see a picture associated with each product
    And when I select the first suggested product
    Then I see the product details page

  @94
  Scenario: If the product has no suggestions, there should not be a section
    Given I select a product with SKU SPORVPU410SKG-375
    Then I do not see suggestions

  @323 @chrome
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

  @726 @ignore
  Scenario: see the timer on Deal of the Day product detail pages
    Given I visit main page
    And I open deal of the day no "1"
    Then I see a timer on product details page that shows when the deal ends
