#encoding: UTF-8
@storefront
Feature: Category page is as expected

    @371
    Scenario: SEO text in category landing page
      Given I am on the homepage
      When I navigate to Category
        | Elektronik | Telefon |
      Then I some see upto 1000 chars of the SEO text
      And when I click on the view more link
      Then I see the full SEO test

    @627
    Scenario: Hide adults items in women's category result page
      Given I am on the homepage
      Given I navigate to Category
        | Giyim, Takı Aksesuar | Kadın |
      Then I should not see adult item "GYJETP060838FULXL" on CLP

  @342
  Scenario: Show product not available indication on CLP
    Given I visit main page
    When I navigate to Category
    | Elektronik | Telefon |
    And I select a sub category in browsing
    | Cep Telefonu ve SmartPhone | Akıllı Telefon |
    And I apply a filter
    | Markalar | Apple |
    Then There should be an indication that some items are not available

  Scenario: Check about variant message on CLP
    Given I visit main page
    When I navigate to Category
    | Elektronik | Telefon |
    Then There are some items with variant indication

  @1043
  Scenario Outline: Check category results count message
    Given I visit main page
    When I navigate to Category
    | <cat1> | <cat2> |
    Then I see the category results message with category name "<name>"
    Examples:
    | cat1                    | cat2             | name |
    | Elektronik              | Isıtma ve Soğutma | Isıtma ve Soğutma |
    | Ev, Yaşam, Ofis          | Ofis / Kırtasiye | Kırtasiye / Ofis |
    | Oto, Bahçe, Yapı Market  | Seramik ve Yer Döşemeleri| Seramik ve Yer Döşemeleri   |
    | Anne, Bebek Oyuncak     | Çocuk Giyim | Çocuk Giyim |
    | Spor Outdoor            | Taraftar ürünleri | Taraftar Ürünleri |
    | Kozmetik Kişisel Bakım  | El & Ayak ve Tırnak Bakımı | El kremleri Ve Bakım Ürünleri |
    | Süpermarket Petshop     | Kağıt & Kozmetik | Kağıt Ürünleri |
    | Kitap, Müzik Film, Hobi | Hobi & Oyun | Hobi |
    | Giyim, Takı Aksesuar    | Altın/Takı/Mücevher | Takı & Mücevher |

  Scenario: Check sorting in CLP
    Given I visit main page
    When I navigate to Category
    | Elektronik | Yazıcılar Tarayıcılar |
    And There are some results available
    Then I should be able to sort on CLP

  @1173
  Scenario: I shouldn't see vodafone campaign filter on smartphone CLP
    Given I visit link "/akilli-telefon-c-371946"
    Then I should not see a filter for "Vodafone"