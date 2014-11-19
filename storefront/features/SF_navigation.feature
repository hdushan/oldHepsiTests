@storefront @navigation
Feature: Navigation by categories is as expected
  As a buyer
  I want to be able to navigate by categories and sub-categories
  So that I can purchase items

  Background:
    Given I am on the homepage

  @47
  Scenario: Hovering over a first level category displays second level categories
    And I see the first level navigation bar
    When I hover over the electronic appliances navigation bar entry
    Then I can see the second level categories


  @48
  Scenario: Navigating to a second level category
    And I see the first level navigation bar
    When I hover over the electronic appliances navigation bar entry
    And I click on the second level category tablet computers
    Then I see the page with the title Bilgisayar Fiyatları ve Modelleri & %45 indirim & Taksit Avantajı

  @305
  Scenario: I can see the third level categories
    Given I navigate to the second level category tablet computers
    Then I can see the third level categories

  @428
  Scenario: I can browse to fourth level categories to buy RAM
    Given I navigate to the second level category tablet computers
    When I click on the computer components category
    #And I select the RAM sub-category
#    Then