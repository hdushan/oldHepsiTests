#encoding: UTF-8
@storefront @product
Feature: Add reviews
  As a buyer
  I want to be able to add reviews on the product page
  So that others can decide on whether to purchase the item

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
    And I log out

  @1015
  Scenario: Check Mandatory Fields
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "bebek maması"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should not be able to submit without mandatory fields
    And I log out

  @1015
  Scenario: Check character limit
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "bebek maması"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I should not be able to pass character limits
    And I log out

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
    And I log out

  @1015
  Scenario: User should not be able to input second comment for same product
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "GYUDEL01SI"
    When I open search result no "1"
    And I click add comment from product description
    Then I add a comment with these values
      | header    | new header                      |
      | review    | new review has been added       |
      | rating    | 4 star                          |
      | show_name | Hayır                           |
    And I get a message about successful comment adding
    Then I click add comment from product description
    And I add a comment with these values
      | header    | second new header                 |
      | review    | second new review has been added  |
      | rating    | 5 star                            |
      | show_name | Evet                              |
    And I get an error message while adding comment "Bu ürünle ilgili onay bekleyen yorumunuz bulunmaktadır. Ürün Yorumlarım sayfanızdan yorumunuzu silerek yeni bir yorum yapabilirsiniz."
    And Admin approves added comment
      | header    | new header                      |
      | review    | new review has been added       |
      | sku       | GYUDEL01SI                      |
    And I see the approved comment on the product detail
      | header    | new header                      |
      | review    | new review has been added       |
      | rating    | 4 star                          |
    Then I click add comment from product description
    And I add a comment with these values
      | header    | third new header                 |
      | review    | third new review has been added  |
      | rating    | 2 star                           |
      | show_name | Evet                             |
    And I get an error message while adding comment "Bu ürünle ilgili yayında olan yorumunuz bulunmaktadır. Ürün Yorumlarım sayfanızdan yorumunuzu silerek yeni bir yorum yapabilirsiniz."
    And I delete comment from db
      | header    | new header                      |
      | review    | new review has been added       |
      | sku       | GYUDEL01SI                      |
    And I log out

  @1015
  Scenario: User should not be able to input more than three comments in a day
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "KTIMAS43484"
    When I open search result no "1"
    And I click add comment from product description
    Then I add a comment with these values
      | header    | new header                      |
      | review    | new review has been added       |
      | rating    | 4 star                          |
      | show_name | Hayır                           |
    And I get a message about successful comment adding
    And I search for "SGBAN512589"
    When I open search result no "1"
    And I click add comment from product description
    Then I add a comment with these values
      | header    | second new header                 |
      | review    | second new review has been added  |
      | rating    | 5 star                            |
      | show_name | Evet                              |
    And I get a message about successful comment adding
    And I search for "SGBRAUNEB25"
    When I open search result no "1"
    And I click add comment from comments tab
    Then I add a comment with these values
      | header    | third new header                 |
      | review    | third new review has been added  |
      | rating    | 2 star                           |
      | show_name | Evet                             |
    And I get a message about successful comment adding
    And I search for "SGOB078678"
    When I open search result no "1"
    Then I click add comment from product description
    And I add a comment with these values
      | header    | fourth new header                 |
      | review    | fourth new review has been added  |
      | rating    | 5 star                            |
      | show_name | Evet                              |
    And I get an error message while adding comment "Üzgünüz, aynı gün içerisinde en fazla 3 yorum yapabilirsiniz."
    And I delete comment from db
      | header    | new header                             |
      | review    | new review has been added              |
      | sku       | KTIMAS43484                            |
    And I delete comment from db
      | header    | second new header                      |
      | review    | second new review has been added       |
      | sku       | SGBAN512589                            |
    And I delete comment from db
      | header    | third new header                       |
      | review    | third new review has been added        |
      | sku       | SGBRAUNEB25                            |
    And I log out

  @1015
  Scenario: User should not be able to add a comment when they have 3 rejects
    Given I visit main page
    And I login with user "alper.mermer@hepsiburada.com" and pass "Aa123456"
    And I search for "KTIMAS43484"
    When I open search result no "1"
    And I click add comment from product description
    Then I add a comment with these values
      | header    | new header                      |
      | review    | new review has been added       |
      | rating    | 4 star                          |
      | show_name | Hayır                           |
    And I get a message about successful comment adding
    And Admin rejects comment for header "new header" and review "new review has been added" and "KTIMAS43484"
    And I click add comment from product description
    Then I add a comment with these values
      | header    | second new header                 |
      | review    | second new review has been added  |
      | rating    | 5 star                            |
      | show_name | Evet                              |
    And I get a message about successful comment adding
    And Admin rejects comment for header "second new header" and review "second new review has been added" and "KTIMAS43484"
    And I click add comment from comments tab
    Then I add a comment with these values
      | header    | third new header                 |
      | review    | third new review has been added  |
      | rating    | 2 star                           |
      | show_name | Evet                             |
    And I get a message about successful comment adding
    And Admin rejects comment for header "third new header" and review "third new review has been added" and "KTIMAS43484"
    And We change date on rejected comment "second new header" "second new review has been added" "KTIMAS43484"
    When I click add comment from product description
    And I add a comment with these values
      | header    | fourth new header                 |
      | review    | fourth new review has been added  |
      | rating    | 5 star                            |
      | show_name | Evet                              |
    Then I get an error message while adding comment "Üzgünüz. Bu ürüne daha fazla yorum yapamazsınız."
    And I delete comment from db
      | header    | new header                             |
      | review    | new review has been added              |
      | sku       | KTIMAS43484                            |
    And I delete comment from db
      | header    | second new header                      |
      | review    | second new review has been added       |
      | sku       | KTIMAS43484                            |
    And I delete comment from db
      | header    | third new header                       |
      | review    | third new review has been added        |
      | sku       | KTIMAS43484                            |
    And I log out