#encoding: UTF-8
@storefront @navigation
Feature: Navigation by categories is as expected
  As a buyer
  I want to be able to navigate by categories and sub-categories
  So that I can purchase items

  @48 @448
  Scenario: I want to navigate to the second level category tablet computers
    Given I am on the homepage
    And I see the first level navigation bar with 9 categories
    When I navigate to Category
      | Elektronik Beyaz Eşya | Bilgisayar Tablet |
    Then I see the page with the title Bilgisayar Fiyatları ve Modelleri & %45 indirim & Taksit Avantajı

  @429
  Scenario: Navigation using breadcrumbs in CLP
    Given I visit main page
    When I navigate to Category
    | Kozmetik Kişisel Bakım | Saç Bakım Ürünleri |
    Then I should see a breadcrumb trail
    And I should be able to visit every link on breadcrumb trail