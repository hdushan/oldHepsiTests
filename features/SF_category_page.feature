#encoding: UTF-8
@storefront
Feature: Category page is as expected

    @372 @discounts_and_topsellers_enabled
    Scenario: Display top seller products on desktop
      Given I am on the homepage
      Given I visit the computers category landing page
      Then I see at least 10 items in top sellers
      And the first top seller product displays the expected fields

    @372 @discounts_and_topsellers_enabled
    Scenario: Clicking through to a top-seller product
      Given I am on the homepage
      Given I visit the computers category landing page
      And I click the bestsellers tab
      Then I click the second top-seller product
      And I see the details page for the selected product

    @373 @discounts_and_topsellers_enabled
    Scenario: Display top discounted products on desktop
      Given I am on the homepage
      Given I visit the computers category landing page
      Then I see 10 items in discounted products
      And the first discounted product displays the expected fields

    @373 @discounts_and_topsellers_enabled
    Scenario: Clicking through to a product
      Given I am on the homepage
      Given I visit the computers category landing page
      When I click the second discounted product
      Then I see the details page for the selected product

    @371
    Scenario: SEO text in category landing page
      Given I am on the homepage
      Given I visit the computers category landing page
      When I click on SEO link
      Then I see a pop up with category title and some SEO text

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
    | Elektronik Beyaz Eşya | Telefon |
    Then There should be an indication that some items are not available
