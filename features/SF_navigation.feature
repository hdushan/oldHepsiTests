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
      | Elektronik  | Bilgisayar/Tablet |
    Then I see the page with the title Bilgisayar Fiyatları ve Modelleri & %45 indirim & Taksit Avantajı

  @429
  Scenario: Navigation using breadcrumbs in CLP
    Given I visit main page
    When I navigate to Category
    | Kozmetik Kişisel Bakım | Saç Bakım Ürünleri |
    Then I should see a breadcrumb trail
    And I should be able to visit every link on breadcrumb trail

  @359 @merchant_disabled
  Scenario: Google a hepsiburada item and open it
    Given I make a google search with "hepsiburada sony playstation"
    When I click on google result no "1"
    Then I don't get the error page

  @359 @merchant_disabled
  Scenario: Clicking header on checkout
    Given I visit main page
    When I go to checkout
    And I click on logo
    Then I don't get the error page

  @359 @merchant_disabled
  Scenario: Return 404 http status on not found product page
    When I visit link "/bunjee-pure-3-kapili-1-cekmeceli-gardirop-p-MBNAYG3KAPI3551CEK"
    Then I get error page

  @359 @merchant_disabled
  Scenario: Return 404 http status on not found category page
    When I visit link "/liste/department.aspx?categoryid=250006687678094&m_redir=0"
    Then I get error page

  @466
  Scenario: Clicking Through Banners
    Given I visit main page
    And I am at main page
    When There are items in carousel
    Then I should cycle through all of them and visit links

  @523
  Scenario Outline: Hover an menu items and check for campaign banners
    Given I visit main page
    When I hover on menu item "<item>"
    Then There are campaign banners
  Examples:
    | item                    |
    | Elektronik              |
    | Ev, Yaşam Ofis          |
    | Oto, Bahçe Yapı Market  |
    | Anne, Bebek Oyuncak     |
    | Spor Outdoor            |
    | Kozmetik Kişisel Bakım  |
    | Süpermarket Petshop     |
    | Kitap, Müzik Film, Hobi |
    | Giyim, Takı Aksesuar    |

  @523
  Scenario Outline: Click on banners and go to relevant pages
    Given I visit main page
    When I hover on menu item "<item>"
    Then I go to the banner links without any error page
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

  @637
  Scenario Outline: Use some single brand filtered links from old site on new site
    Given I visit main page
    When I use this link form old site to access new site "<link>"
    Then I am on results page
    And These filters are present on page "<brand-list>"
  Examples:
    | link                                                                                                             | brand-list |
    | /liste/dark-bilgisayarlar/department.aspx?categoryId=3000500&qs=%2fbrand%3d%7bdark%7d                            | Dark       |
    | /liste/matras-erkek/department.aspx?categoryId=12087177&qs=%2fbrand%3d%7bmatra015f%7d                            | Matraş       |

  @637
  Scenario Outline: Use multiple brand filtered links from old site on new site
    Given I visit main page
    When I use this link form old site to access new site "<link>"
    Then I am on results page
    And These filters are present on page "<brand-list>"
  Examples:
    | link                                                                                                                 | brand-list |
    | /liste/bilgisayarlar/department.aspx?categoryId=3000500&qs=%2fbrand%3d%7bdark%3btoshiba%7d                           | Dark - Toshiba       |
    | /liste/fotograf-makinesi-cantalari/department.aspx?categoryId=81481&qs=%2fbrand%3d%7bvanguard%3blowepro%3bsamsung%7d | Lowepro - Vanguard - Samsung  |

  @650
  Scenario: Go to product details page for viewing breadcrumbs and check them in GWT
    Given I visit main page
    And I search for "EAKMETGM153-90190"
    When I open search result no "1"
    And I store breadcrumbs
    Then breadcrumbs should be available on google webtools

  @650
  Scenario Outline: Go to catalog landing pages and check the breadcrumbs in GWT
    Given I visit main page
    When I navigate to Category
      | <cat1> | <cat2> |
    And I store breadcrumbs
    Then breadcrumbs should be available on google webtools
  Examples:
    | cat1                   | cat2                  |
    | Kozmetik Kişisel Bakım | Duş ve Banyo Ürünleri |
    | Spor Outdoor           | Spor Branşları        |
    | Ev, Yaşam Ofis         | Ev Tekstili           |

  @739
  Scenario Outline: Hide discount an top seller fields if they are disabled
    Given I visit main page
    And I navigate to Category
      | <cat1> | <cat2> |
    When I am on results page
    Then There are some results available
    And Top sellers an discount items are not visible
  Examples:
    | cat1         | cat2           |
    | Spor Outdoor | Spor Branşları |
    | Oto, Bahçe   | Banyo          |

  @958
  Scenario: Show thumbnails on carousel
    Given I visit main page
    When There are items in carousel
    Then I see thumbnails on carousel

  @962
  Scenario: See deal of the day counter on homepage
    Given I visit main page
    When There are some items in deal of the day carousel
    Then I should see the counter on deal of the day items

  @977
  Scenario: See products of the week
    Given I visit main page
    When There is the products of the week widget
    Then These are items in products of the week
    And I am able to cycle through products of the week

  @976
  Scenario: See 9 static banners on homepage
    Given I visit main page
    When There are "9" static banners on homepage
    Then I should be able to visit every static banner