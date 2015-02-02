#encoding: UTF-8
@storefront

Feature: Mobile Homepage is as expected
  As a researcher
  I want to navigate around the site
  So that I can navigate to products or find information relevant to me

  @248
  Scenario: Show social icons in footer
    Given I am on the homepage
    And I clear the browsers cookies
    Given I visit mobile main page
    Then I see the social icons in the footer
    And I see the security logo in the footer
    And I see the copyright message in the footer

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
    And I select a sub category in mobile
      | Spor / Fitness | Spor Branşları |
    When I click the Hepsiburada logo
    Then I should be redirected to mobile Homepage

  @355
  Scenario: Testing
    Given I visit mobile main page
    When I click go to desktop version link
    Then I am on old hepsiburada mainpage

  @312
  Scenario: Clear filters button should be disabled if no filter active and enabled if a filter is applied
    Given I visit mobile main page
    When I navigate to Mobile_Category
    | Ev Elektroniği |
    And I select a sub category in mobile
    | Ses ve Görüntü Sistemleri |
    Then Clear button in filter should be disabled
    And I apply a filter on mobile
    | Markalar            | Philips |
    | Değerlendirme Puanı | 4 Yıldız |
    Then Clear button in filter should be enabled

  @246
  Scenario: Cleared results page
    Given I visit mobile main page
    And I navigate to Mobile_Category
      | Anne / Bebek / Oyuncak |
    And I select a sub category in mobile
      | Anne / Bebek |
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

  @51
  Scenario: Go to login page on mobile
    Given I visit mobile main page
    When I click my account button on mobile
    Then I am on mobile login page

  @456_mobile
  Scenario Outline: Visit mobile site with links from legacy site
    Given I visit mobile main page
    When I use this link form old site to access mobile site "<link>"
    Then I don't get the error page
  Examples:
    | link |
    | /liste/sony-playstation-4-500-gb-oyun-konsolu/productDetails.aspx?productId=oyunsonyplays4&categoryId=60003892&SKU=OYUNSONYPLAYS4 |
    | /liste/prima-bebek-bezi-aktif-bebek-aylik-paketi-cesitleri-prima-islak-havlu-hediyeli-/productDetails.aspx?productId=zypyon2897&categoryId=60001049&SKU=ZYPYON2897 |
    | /liste/petlas-175-70-r13-82t-snow-master-w601-kis-oto-lastigi-uretim-yili-2014-/productDetails.aspx?productId=otozsu20550&categoryId=259720&SKU=OTOZSU20550 |
    | /liste/mini-masallar-seti-3-10-kitap/productDetails.aspx?productId=ktimas43484&categoryId=9928&SKU=KTIMAS43484 |
    | /liste/ceyrek-altin-kulplu/productDetails.aspx?productId=eakszynt7&categoryId=16032976&SKU=EAKSZYNT7 |

  @637_mobile
  Scenario Outline: Use some single brand filtered links from old site on new site
    Given I visit mobile main page
    When I use this link form old site to access mobile site "<link>"
    Then I am on results mobile page
    And These filters are present on mobile page "<brand-list>"
  Examples:
    | link                                                                                                             | brand-list |
    | /liste/dark-bilgisayarlar/department.aspx?categoryId=3000500&qs=%2fbrand%3d%7bdark%7d                            | Dark       |
    | /liste/matras-erkek/department.aspx?categoryId=12087177&qs=%2fbrand%3d%7bmatra015f%7d                            | Matraş     |

  @637_mobile
  Scenario Outline: Use multiple brand filtered links from old site on mobile site
    Given I visit mobile main page
    When I use this link form old site to access mobile site "<link>"
    Then I am on results page
    And These filters are present on mobile page "<brand-list>"
  Examples:
    | link                                                                                                                 | brand-list                     |
    | /liste/bilgisayarlar/department.aspx?categoryId=3000500&qs=%2fbrand%3d%7bdark%3btoshiba%7d                           | Dark - Toshiba                 |
    | /liste/fotograf-makinesi-cantalari/department.aspx?categoryId=81481&qs=%2fbrand%3d%7bvanguard%3blowepro%3bsamsung%7d | Lowepro - Vanguard - Samsung   |

  @739
  Scenario: Hide discount and top seller fields if they are disabled for Spor Outdoor
    Given I visit mobile main page
    And I navigate to Mobile_Category
      | Spor Outdoor |
    When I select a sub category in mobile
      | Spor / Fitness | Spor Branşları |
    Then There are some results available
    And Top sellers an discount items are not visible

  @739
  Scenario: Hide discount and top seller fields if they are disabled for Telefon
    Given I visit mobile main page
    And I navigate to Mobile_Category
      | Telefon |
    When I select a sub category in mobile
      | Cep Telefonu ve SmartPhone |
    Then There are some results available
    And Top sellers an discount items are not visible