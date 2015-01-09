#encoding: UTF-8
@storefront
Feature: Category page is as expected

    @371
    Scenario: SEO text in category landing page
      Given I am on the homepage
      Given I navigate to Category
        | Elektronik | Bilgisayar Tablet |
      When I click on SEO link
      Then I see a pop up with category title and some SEO text

    @627
    Scenario: Hide adults items in women's category result page
      Given I am on the homepage
      Given I navigate to Category
        | Giyim, Takı Aksesuar | Kadın |
      Then I should not see adult item "GYJETP060838FULXL" on CLP

  @342
  Scenario: Show product not available indication on CLP
    Given I visit main page
    When I navigate to Category
    | Elektronik | Telefon |
    And I select a sub category in browsing
    | Cep Telefonu ve SmartPhone | Akıllı Telefon |
    And I apply a filter
    | Markalar | Apple |
    Then There should be an indication that some items are not available

  @448
  Scenario Outline: Hover an menu items and check content
    Given I visit main page
    When I hover on menu item "<item>"
    Then There are items in the menu content
  Examples:
    | item                    |
    | Elektronik   |
    | Ev, Yaşam Ofis          |
    | Oto, Bahçe Yapı Market  |
    | Anne, Bebek Oyuncak     |
    | Spor Outdoor            |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |
    | Kitap, Müzik Film, Hobi |
    | Giyim, Takı Aksesuar    |

  @448
  Scenario Outline: Hover an menu items and check content
    Given I visit main page
    And I hover on menu item "<item>"
    When I store links from this menu item
    Then I visit these links without an error page
  Examples:
    | item                    |
    | Elektronik   |
    | Ev, Yaşam Ofis          |
    | Oto, Bahçe Yapı Market  |
    | Anne, Bebek Oyuncak     |
    | Spor Outdoor            |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |
    | Kitap, Müzik Film, Hobi |
    | Giyim, Takı Aksesuar    |

  Scenario: Check about variant message on CLP
    Given I visit main page
    When I navigate to Category
    | Elektronik | Telefon |
    Then There are some items with variant indication
