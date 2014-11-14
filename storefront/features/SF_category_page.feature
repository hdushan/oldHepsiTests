@storefront
Feature: Category page is as expected

  Background:
    Given I am on the homepage
    And I visit the computers category landing page

    @372
    Scenario: Display top seller products on desktop
      Then I see 10 items in top sellers
      And the first top seller product displays the expected fields

    @372
    Scenario: Clicking through to a top-seller product
      Then I click the second top-seller product
      And I see the details page for the selected product

    @373
    Scenario: Display top discounted products on desktop
      Then I see 10 items in discounted products
      And the first discounted product displays the expected fields

    @373
    Scenario: Clicking through to a product
      When I click the second discounted product
      Then I see the details page for the selected product

    @371
    Scenario: SEO text in category landing page
      When I click on SEO link
      Then I see a pop up with category title and some SEO text
