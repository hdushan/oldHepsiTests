#encoding: UTF-8
Feature: See campaign banners on menu flyers
  As a product owner
  I want to see campaign banners in flyout menu
  So that i can annouce shiny campaings to my visitors

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

