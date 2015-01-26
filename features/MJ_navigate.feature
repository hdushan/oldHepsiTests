#encoding: UTF-8
@journey
  Feature: Navigate for mobile

    @mobile_compatibles_enabled
    Scenario: Search for a product
      Given I visit mobile main page
      When I search for "anakart"
      Then There are some results available
      And I open search result no "3"
#Scenario: Check product details
      Given I am on product details
      Then I see product description
      And I see product specifications
      And I see product reviews
      And I see compatible products
      And I see return policy
      And I view the payment installments information
#Scenario: Check variants and increase item count
      Given I search for "gömlek"
      And I open search result no "1"
      And I am on product details
      When I select a variant
      | box | renk  | lacivert-beyaz-ekose |
      | box | beden | m                    |
      And I increase item count by "2"
      And I decrease item count by "1"
      Then I add to cart
      And I should see a notification of 2 items added to my basket
#Scenario: Check topsellers and recommended products on detail
      Given I search for "iphone"
      And I open search result no "1"
      When I am on product details
      Then There is a top sellers section in mobile
      And There is a recommended products section in mobile


