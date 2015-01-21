#encoding: UTF-8
@storefront @product
Feature: Tabs on the Product details page
  As a buyer
  I want to be able to see more info about the product on the product page
  So that I can decide on whether to purchase the item

  @73
  Scenario: Display product tech specs
    Given I select a product with SKU TELCEPSAMN910-B
    Then I can view the product tech specs

  @68
  Scenario: Display payment installment options with table-based information
    Given I select a product with SKU SPORALTISSD5000
    When I view the payment installments information
    Then I see at least one payment installment table

  @139
  Scenario: I see the instalments on a valid product
    Given I select a product with SKU MTHOTARWMF903EU
    Then I should see the installments section

  @139
  Scenario: I should not see the installments section on an invalid product
    Given I select a product with SKU EAKSERELEKTBAT
    Then I should not see the installments section

  @318
  Scenario: Clicking through technical specs
    Given I visit main page
    And I search for "ZYPYON2897"
    And I open search result no "1"
    And I am on product details
    When I click product specs tab
    Then I get the product specs

  @68
  Scenario: No installment
    Given I visit main page
    When I search for "TELCEPSAMN9000-B"
    And I open search result no "1"
    Then There is no installment option for this product

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

  @93
  Scenario: Go to compatible products details
    Given I visit main page
    And I search for "BD730092"
    And I open search result no "1"
    When I click on compatible products tab
    Then All compatible products details should be accessible