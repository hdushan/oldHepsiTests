#encoding: UTF-8
@storefront @navigation
Feature: Navigation by categories is as expected
  As a buyer
  I want to be able to navigate by categories and sub-categories
  So that I can purchase items

  Background:
    Given I am on the homepage

  @47 @448
  Scenario: Browsing through mega flyout menu on desktop
    And I see the first level navigation bar with 9 categories
    When I hover over the electronic appliances navigation bar entry
    Then I can see the second level categories

  @48 @448
  Scenario: I want to navigate to the second level category tablet computers
    And I see the first level navigation bar with 9 categories
    When I hover over the electronic appliances navigation bar entry
    And I click on the second level category tablet computers
    Then I see the page with the title Bilgisayar Fiyatları ve Modelleri & %45 indirim & Taksit Avantajı

  @305
  Scenario: I can see the third level categories
    Given I navigate to the second level category tablet computers
    Then I can see the third level categories

  @428 @429 @flaky
  Scenario: I can browse to the fourth level categories to buy RAM
    Given I navigate to the RAM sub-category
    Then I can see the RAM breadcrumb

  @429
  Scenario: Enable a consumer to navigate using the breadcrumb trail
    Given I navigate to the RAM sub-category
    When I click the breadcrumb with ID breadcrumbFor-8
    Then I see the page with the title Bilgisayar Parçaları ve Bilgisayar Kasası | Bilgisayar Bileşenleri
