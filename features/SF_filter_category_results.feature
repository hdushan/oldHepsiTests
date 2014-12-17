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

  @745 
  Scenario: Sorting CLP results when applied filter
    Given I am on the homepage
    And I navigate to Category
      | Giyim, Takı Aksesuar | Çocuk Giyim |
    When I apply a filter
      | Markalar  | Köstebek  |
      | Beden     | 5 Yaş |
    And There are some results available
    And I store filter results
    And I sort with "most-selling" filter
    Then I should have same items in the results
    When I sort with "lowest-price" filter
    Then I should have same items in the results
    When I sort with "highest-price" filter
    Then I should have same items in the results
    When I sort with "bestMatching" filter
    Then I should have same items in the results


