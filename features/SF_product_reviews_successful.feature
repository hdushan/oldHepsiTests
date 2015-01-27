#encoding: UTF-8
@storefront @product
Feature: Add reviews
  As a buyer
  I want to be able to add reviews on the product page
  So that others can decide on whether to purchase the item

  @1015 @add_comments_test  @logout_after_test
  Scenario: Successful comment input
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "AILEMLP001001070"
    When I open search result no "1"
    And I click add comment from product description
    Then Comment fields should appear as expected
    Then I add a comment with these values
    | header    | başlık                          |
    | review    | bu review ı yazan adam kör oldu |
    | rating    | 3 star                          |
    | show_name | Evet                            |
    | sku       | AILEMLP001001070                |
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