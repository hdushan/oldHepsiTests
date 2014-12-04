#encoding: UTF-8
@storefront
Feature: Filter category results

  @343
  Scenario: Filter by specific attribute
    Given I am on the homepage
    And I visit the telephones category page
    And I can see the results
    When I filter by material type
    Then I should only see products that fall under my preset range

  @36
  Scenario: Show fast shipping indicator in category results page for product that offers fast shipping
    Given I am on the homepage
    And I navigate to Category
      | Elektronik Beyaz Eşya | Telefon |
    When I apply a filter
    | Markalar            | Samsung   |
    | İşletim Türü        | Android   |
    Then I should see Fast Shipping offered for product "Samsung i9060 Galaxy Grand Neo"