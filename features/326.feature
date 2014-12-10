#encoding: UTF-8

  @merchant_enabled
Feature: 326 - Expand Header to Desktop
  As a buyer
  I want to see expanded version of header on desktop
  So that i can use existing mobile features on desktop too.

  Scenario: Searching for a product
    Given I visit main page
    When I search for "ayakkabı"
    Then There are some results available

  Scenario: Going to checkout
    Given I visit main page
    When I search for "kulaklık"
    And I open search result no "4"
    And I add "3" product(s) to cart
    Then I go to checkout
    And Product is listed in the checkout screen

  Scenario: Check menu on the details page
    Given I visit main page
    When I search for "saat"
    And I open search result no "3"
    Then I am on product details

  Scenario Outline: Menu should be available on details page
    When I hover on menu item "<item>"
    Then There are items in the menu content
  Examples:
    | item                    |
    | Elektronik Beyaz Eşya   |
    | Ev, Yaşam Ofis          |
    | Oto, Bahçe Yapı Market  |
    | Anne, Bebek Oyuncak     |
    | Spor Outdoor            |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |
    | Kitap, Müzik Film, Oyun |
    | Giyim, Takı Aksesuar    |

  Scenario: Check menu on the CLP
    Given I visit main page
    When I navigate to Category
    | Kitap, Müzik Film, Oyun | Müzik Enstrümanları |
    Then There are some results available

  Scenario Outline: Menu should be available on CLP
    When I hover on menu item "<item>"
    Then There are items in the menu content
  Examples:
    | item                    |
    | Elektronik Beyaz Eşya   |
    | Ev, Yaşam Ofis          |
    | Oto, Bahçe Yapı Market  |
    | Anne, Bebek Oyuncak     |
    | Spor Outdoor            |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |
    | Kitap, Müzik Film, Oyun |
    | Giyim, Takı Aksesuar    |