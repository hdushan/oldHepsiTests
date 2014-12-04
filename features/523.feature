#encoding: UTF-8

Feature: I should see breadcrums in search engine optimisation tools
  As a SEO manager
  I want breadcrumb information to be visible as part of search engine microdata
  So that I maximise Hepsiburada’s crawlability

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

  Scenario Outline: Hover an menu items and check for campaign banners
    When I hover on menu item "<item>"
    Then There are campaign banners
    And I unhover
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

  Scenario Outline: Click on first small banner and go to product details
    Given I hover on menu item "<item>"
    When I click on first small banner
    Then I don't get the error page
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

  Scenario Outline: Click on first small banner and go to product details
    Given I hover on menu item "<item>"
    When I click on second small banner
    Then I don't get the error page
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

  Scenario Outline: Click on first small banner and go to product details
    Given I hover on menu item "<item>"
    When I click on big banner
    Then I don't get the error page
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

