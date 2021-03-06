#encoding: UTF-8
@journey
Feature: Browse categories and apply a filter to find a product
  As a customer
  I want to be able to browse a product and apply a filter
  In order to add it to cart

  @clear_data_and_close_browser_after_test
  Scenario: Visit site
    Given I visit main page
    Then I am at main page
  #Scenario: Browse Category
    Given I navigate to Category
      | Elektronik | Çevre Birimleri |
    When I am on results page
    Then There are some results available
  #Scenario: Apply Filter
    Given I select a sub category in browsing
    | Mouse |
    And There are some results available
    When I apply a filter
    | MarkalarFAIL            | Everest |
    | Değerlendirme Puanı | 4 yıldız |
    | Fiyat Aralığı       | 0 TL - 25 TL |
    | Algılama            | Laser      |
    Then There are some results available
  #Scenario: Go to product details and add to cart
    Given I open search result no "1"
    When I am on product details
    Then I add "4" product(s) to cart
  #Scenario: Go to checkout
    When I am on checkout screen
    Then Product is listed in the checkout screen
    When I visit main page
    Then I see the cart item count is 1