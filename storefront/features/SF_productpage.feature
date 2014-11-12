@storefront @product
Feature: Product page is as expected
  As a buyer
  I want to be able to see things on the product page
  So that I can decide on whether to purchase the item

  @143 @60 @19 @61 @62 @83
  Scenario: Display Product information
    Given I select a product with SKU TELCEPIPH5C16GPM-N
    Then I see the product information

  @56
  Scenario: Page title contains product name
    Given I select a product with SKU TELCEPIPH5C16GPM-N
    Then the page title contains the product name

  @84
  Scenario: Display product reviews
    Given I select a product with SKU TELCEPIPH5C16GPM-N
    Then I see 3 reviews
    And I can see the 'More Reviews' button

  @78
  Scenario: Display returns policy
    Given I select a product with SKU TELCEPIPH5C16GPM-N
    And I see to link to view the returns policy
    When I click on the returns policy link
    Then I see the returns policy

  @73
  Scenario: Display product tech specs
    Given I select a product with SKU TELCEPIPH5C16GPM-N
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

  @144
  Scenario: Display variants on the details page
    Given I select a product with SKU TELCEPSAMI8200-B
    Then I see the option to select a variant
    And I see no variant is selected
    When I add to cart
    Then I see an error message asking me to make a selection

  @144
  Scenario: Select variant on results page
    Given I select a product with SKU TELCEPSAMI8200-B
    When I select the first a variant
    Then I see the the variant is checked

  @138
  Scenario: Display original price on details page
    Given I select a product with SKU KIMGE033
    Then I see the original price
    And I see the discount percentage

  @140
  Scenario: Display non-generic returns policy for DVD
    Given I select a product with SKU DVDVIDEO1373
    When I click on the returns policy link
    Then I see product return information specific to media