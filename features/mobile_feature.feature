#encoding: UTF-8
@storefront

Feature: Mobile Homepage is as expected
  As a researcher
  I want to navigate around the site
  So that I can navigate to products or find information relevant to me

  @10
  Scenario: Clicking around Storefront
    Given I visit mobile main page
    Given I am at mobile main page
    When I click the Hepsiburada logo
    Then I should be redirected to mobile Homepage

  @10
  Scenario: Navigating back Storefront
    Given I visit mobile main page
    Given I am at mobile main page
    And I navigate to Mobile_Category
      | Spor Outdoor |
    And I select a sub category in browsing
      | Spor / Fitness | Spor Branşları | Tümünü Gör |
    When I click the Hepsiburada logo
    Then I should be redirected to mobile Homepage

  @312
  Scenario: Clear filters button should be disabled
    Given I visit mobile main page
    When I navigate to Mobile_Category
    | Ev Elektroniği |
    And I select a sub category in browsing
    | Ses ve Görüntü Sistemleri | Tümünü Gör |
    Then Clear button in filter should be disabled

  @312
  Scenario: Clear filters button should be enabled
    Given I visit mobile main page
    When I navigate to Mobile_Category
    | Ev Elektroniği |
    And I select a sub category in browsing
    | Ses ve Görüntü Sistemleri | Tümünü Gör |
    And I apply a filter on mobile
    | Markalar            | Philips |
    | Değerlendirme Puanı | 4 Yıldız |
    Then Clear button in filter should be enabled
