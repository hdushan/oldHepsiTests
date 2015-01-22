#encoding: UTF-8
@storefront @product
Feature: View Reviews
  As a buyer
  I want to be able to see reviews on the product page
  So that I can decide on whether to purchase the item

  @84
  Scenario: Display product reviews
    Given I select a product with SKU SPORALTISSD5000
    Then I see at least 3 reviews
    And I can see the 'More Reviews' button

  @83
  Scenario: Ratings of a product on details page
    Given I visit main page
    When I search for "TELCEPSAMN9000-B"
    And I open search result no "1"
    Then I am on product details
    And There are "3" comments on details
    And I see the number of reviews

  @83
  Scenario: No ratings
    Given I visit main page
    When I search for "TELKULSENN10109"
    And I open search result no "1"
    Then I am on product details
    And There are no comments on details

  @318
  Scenario: Comments
    Given I visit main page
    And I search for "ZYPYON2897"
    And I open search result no "1"
    When I am on product details
    And There are "3" comments on details
    And I click on more comments button
    Then There are "6" comments on details

  @329
  Scenario: Anonymizing comments - male
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "male" person

  @329
  Scenario: Anonymizing comments - female
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "female" person

  @329
  Scenario: Adhering to the existing commenting structure
    Given I visit main page
    When I search for "ZYPYON2897"
    And I open search result no "1"
    Then I should see a comment made by a "normal" person

  @984
  Scenario: View reviews through reviews tab
    Given I visit main page
    When I search for "anakart"
    And I open search result no "2"
    And I click reviews tab
    Then I see reviews tab

  @984
  Scenario: View reviews through reviews link
    Given I visit main page
    When I search for "EVDEMIRNITROMIXP24"
    And I open search result no "1"
    And I click reviews link on details
    Then I see reviews tab

  @984
  Scenario: View more reviews
    Given I visit main page
    And I search for "nokia asha 501"
    When I open search result no "1"
    And I click reviews tab
    Then There are "3" comments on details
    When I click on more comments button
    Then There are "6" comments on details
    When I click on more comments button
    Then There are "9" comments on details

  @984
  Scenario: Rate reviews as positive
    Given I visit main page
    And I search for "OTCTN115725"
    When I open search result no "1"
    And I click reviews link on details
    And I mark review no "1" as "positive"
    Then In comment no "1" some rating message appears
    When I refresh page
    And I click reviews tab
    And I mark review no "1" as "negative"
    Then In comment no "1" some rating message appears

  @984
  Scenario: Rate reviews as negative
    Given I visit main page
    And I search for "KCIZMELIKEDI53504"
    When I open search result no "1"
    And I click reviews link on details
    And I mark review no "1" as "negative"
    Then In comment no "1" some rating message appears
    When I refresh page
    And I click reviews tab
    And I mark review no "1" as "negative"
    Then In comment no "1" some rating message appears

  @984
  Scenario: See no reviews
    Given I visit main page
    When I search for "OUTSENI75507"
    And I open search result no "1"
    Then There is not a reviews link on details
    When I click reviews tab
    Then I see an empty reviews section
