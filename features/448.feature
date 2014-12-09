#encoding: UTF-8
@chrome
Feature: 448 - Mega flyout menu for desktop
  As a user
  I want to browse easily through categories
  So that i can quickly find categories i'm looking for

  Scenario: Go to main page
    Given I visit main page
    Then I am at main page

  Scenario Outline: Hover an menu items and check content
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

  Scenario Outline: Hover an menu items and check content
    Given I hover on menu item "<item>"
    When I store links from this menu item
    Then I visit these links without an error page
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


