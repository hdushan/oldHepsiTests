# encoding: UTF-8
@storefront
Feature: Homepage is as expected
  As a buyer
  I want to be able to see things on the homepage
  So that I can navigate the site to purchase items

  @16  @326
  Scenario: Searching, with results
    Given I am on the homepage
    And I clear the browsers cookies
    When I search for "iPhone"
    Then There are some results available
    And I should see a list of iPhone results

  @16
  Scenario: Searching, with no results
    Given I am on the homepage
    And I clear the browsers cookies
    When I search for "iPhonethatdoesnotexist"
    Then I should see no results page

  @33
  Scenario: Searching with one character does not produce suggestions
    Given I am on the homepage
    And I clear the browsers cookies
    Given I have input s into search
    Then I see no suggestions based on my inputs

  @33
  Scenario: Searching with at least two characters begins producing suggestions
    Given I am on the homepage
    And I clear the browsers cookies
    Given I have input sam into search
    And I see the auto complete suggestions
    Then I see suggestions based on sa
    And I see 3 categories and 10 other keywords

  @33
  Scenario: Search suggestions update as user enters in more or less into search
    Given I am on the homepage
    And I clear the browsers cookies
    Given I have input sam into search
    And I see the auto complete suggestions
    And I see suggestions based on sam
    When I append u into search
    And I wait for auto complete results to update
    Then I see suggestions based on samu

  @33
  Scenario: Ability to navigate through search suggestions
    Given I am on the homepage
    And I clear the browsers cookies
    Given I have input sam into search
    And I see the auto complete suggestions
    When I press the down arrow
    Then I see a visual indication that an auto complete suggestion is selected

  @33
  Scenario: Selecting a search suggestion takes me to the corresponding search results
    Given I am on the homepage
    And I clear the browsers cookies
    Given I have input samsung into search
    And I see the auto complete suggestions
    And I see suggestions based on samsung
    When I click on the first search suggestion
    Then I see products relating to samsung

  @33
  Scenario: Searching without selecting a suggestion
    Given I am on the homepage
    And I clear the browsers cookies
    Given I have input samsung into search
    And I do not like any of the auto complete suggestions
    When I invoke search on my own keywords
    Then I see products relating to samsung

  @437
  Scenario Outline: Storefront footer check
    Given I am on the homepage
    And I clear the browsers cookies
    Then I see link "<link_text>" that navigates to "<link>" in a "<new_tab>" if required and with the right SEO attribute "<seo_attribute>"
  Examples:
    | link_text                         | link                                                                        | new_tab | seo_attribute |
  # Hepsiburada.com
    | Hakkımızda                        | http://www.hepsiburada.com/hakkimizda                                       |   N     |       Y       |
    | Bize Ulaşın                       | http://www.hepsiburada.com/bize-ulasin                                      |   N     |       Y       |
    | İletişim                          | http://www.hepsiburada.com/iletisim                                         |   N     |       Y       |
    | Hesabım                           | https://www.hepsiburada.com/ayagina-gelsin/giris?ReturnUrl=/liste/MyPage/   |   N     |       Y       |
    | Yardım                            | http://www.hepsiburada.com/liste/MyPage/Yardim                              |   N     |       Y       |
    | Hepsiburada.com Twitter Destek    | https://twitter.com/HBAysenur                                               |   Y     |       Y       |
    | Mobil Uygulamalar                 | http://www.hepsiburada.com/mobil-uygulamalar                                |   N     |       N       |
  # Kariyer
    #| Kariyer Fırsatları                | javascript:bizimleCalismakIsterMisiniz()                                    |   N     |       Y       |
    | Yenibiris.com                     | http://yenibiris.com/                                                       |   Y     |       Y       |
  # Ödeme
    | Ödeme Seçenekleri                 | http://www.hepsiburada.com/odeme-secenekleri                                |   N     |       Y       |
    | Banka Kampanyaları                | http://www.hepsiburada.com/banka-kampanyalari                               |   N     |       Y       |
  #Kurumsal
    | İş Ortaklığı                      | http://b2b.hepsiburada.com                                                  |   N     |       Y       |
    | Kurumsal Satış                    | http://www.hepsiburada.com/KurumsalSatis.aspx                               |   N     |       Y       |
   #Bizi Takip Edin
    | Facebook                          | https://www.facebook.com/Hepsiburada                                        |   Y     |       Y       |
    | Twitter                           | https://twitter.com/hepsiburada                                             |   Y     |       Y       |
    | LinkedIn                          | https://www.linkedin.com/company/hepsiburada.com                            |   Y     |       Y       |
    | Google+                           | https://plus.google.com/+hepsiburada                                        |   Y     |       Y       |
    | Pinterest                         | http://www.pinterest.com/hepsiburada/                                       |   Y     |       Y       |
    | Instagram                         | http://instagram.com/hepsiburada                                            |   Y     |       Y       |
    | YouTube                           | https://www.youtube.com/hepsiburada                                         |   Y     |       Y       |
   #Mobil Uygulamalar

  @320 @223
  Scenario: Check page title
    Given I visit main page
    Then The page title is "Türkiye'nin En Büyük Online Alışveriş Sitesi Hepsiburada.com"
    And Favicon should be on page

  @223
  Scenario: Include favicon on mobile
    Given I visit mobile main page
    Then Favicon should be on mobile page

#  @484
#  Scenario: Checking opt-in and opt-out bar on existing website
#    Given I visit legacy home page
#    When I see opt-in bar
#    And I click opt-in button
#    Then I am at main page
#    And I see opt-out bar
#    When I click opt-out button
#    Then I am on old hepsiburada mainpage

  @484
  Scenario: Never shoving opt-in bar again
    Given I visit legacy home page
    When I see opt-in bar
    And I click never show link
    Then I don't see the opt-in bar
    And I refresh page
    And I don't see the opt-in bar
    And I visit link "http://www.google.com"
    And I visit legacy home page
    And I don't see the opt-in bar

  @950
  Scenario: See top sellers on homepage
    Given I visit main page
    When There are "11" items in top sellers section
    Then I should be able to cycle all topsellers

  @326
  Scenario: Check menu on the details page
    Given I visit main page
    When I search for "saat"
    And I open search result no "3"
    Then I am on product details
    When I hover on menu item "Elektronik"
    Then There are items in the menu content
    When I hover on menu item "Ev, Yaşam, Ofis"
    Then There are items in the menu content

  @326
  Scenario: Check menu on the CLP
    Given I visit main page
    When I navigate to Category
      | Kitap, Müzik Film, Hobi | Müzik Enstrümanları |
    Then There are some results available
    When I hover on menu item "Spor Outdoor"
    Then There are items in the menu content
    When I hover on menu item "Ev, Yaşam, Ofis"
    Then There are items in the menu content
    When I hover on menu item "Süpermarket Petshop"
    Then There are items in the menu content

#  @481
#  Scenario: Check for feedback button on homepage
#    Given I visit main page
#    When There is a feedback button on current page
#    Then There should be a way for me to give feedback
#
#  @481
#  Scenario: Check for feedback button on CLP
#    Given I visit main page
#    And I navigate to Category
#      | Anne, Bebek Oyuncak | Bebek Güvenlik |
#    When There is a feedback button on current page
#    Then There should be a way for me to give feedback
#
#  @481
#  Scenario: Check for feedback button on product details page
#    Given I visit main page
#    And I search for "SGBABYLISS087307"
#    When There is a feedback button on current page
#    Then There should be a way for me to give feedback

  @1024  @1037
  Scenario: Check for new label on footer
    Given I visit main page
    Then There is a link in the footer with label "Özel Sayfalar"
    And There are these propositions
    | Kolay İade          | Aldığınız ürünü iade etmek hiç bu kadar kolay olmamıştı. |
    | Bugün Teslimat      | Saat 14:00'e kadar verdiğiniz siparişler aynı gün kapınızda. |
    | Tek Tıkla Alışveriş | Ödeme ve adres bilgilerinizi kaydedin, tek tıkla alışverişin keyfini yaşayın. |
    | Mobil Cebinizde     | Dilediğiniz her yerden güvenli alışverişin keyfini çıkarın. |


