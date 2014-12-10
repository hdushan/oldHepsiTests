#encoding: UTF-8

@storefront
Feature: Static pages

  @660
  Scenario: View Static Page
    Given I visit a static page with id "6696"
    Then I see the static page with title "Ultra Hd Led Tv Modelleri ve Fiyatları & % 70 indirim & 9 Taksit" and canonical link "/ultra-hd-led-tv" and content "Sony KDL-49X8505B"
