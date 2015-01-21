#encoding: UTF-8
@storefront @product
Feature: Product page for product with variants
  As a buyer
  I want to be able to see variants on the product page
  So that I can decide on whether to purchase the item

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