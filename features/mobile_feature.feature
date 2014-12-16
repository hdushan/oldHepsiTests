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

  @246
  Scenario: Cleared results page
    Given I visit mobile main page
    And I navigate to Mobile_Category
      | Anne / Bebek / Oyuncak |
    And I select a sub category in browsing
      | Anne / Bebek | Tümünü Gör |
    And I store search result count
    When I apply a filter on mobile
      | Markalar            | Chicco   |
      | Değerlendirme Puanı | 4 yıldız |
    And I clear filters on mobile
    Then Current search results count should be same as the first one
    And Clear button in filter should be disabled

  @246
  Scenario: Both clear and apply active
    Given I visit mobile main page
    And I search for "sony"
    And I store search result count
    When I apply a filter on mobile
      | Sanatçı | VARIOUS ARTISTS |
      | Format  | CD              |
    And I apply a filter on mobile
      | Sanatçı | DEPECHE MODE |
    Then Clear button in filter should be enabled
    And Apply button in filter should be enabled

  @246
  Scenario: Unchecking a filter still persists
    Given I visit mobile main page
    And I search for "terlik"
    And I apply a filter on mobile
    | Markalar     | Twigy |
    And I store filtered search result count
    And I apply a filter on mobile
    | Topuk Modeli | Düz Topuk |
    When I remove filters on mobile
    | Topuk Modeli | Düz Topuk |
    Then Current filtered results count should be same as the first one

  @246
  Scenario: Unchecking all filters means change of clear state
    Given I visit mobile main page
    And I search for "çakı"
    And I store search result count
    And I apply a filter on mobile
      | Markalar            | Victorinox |
      | Değerlendirme Puanı | 4 yıldız |
      | Kategori            | Çakı - Bıçak |
    When I remove filters on mobile
      | Markalar            | Victorinox |
      | Değerlendirme Puanı | 4 yıldız |
      | Kategori            | Çakı - Bıçak |
    Then Current search results count should be same as the first one