Feature: Navigation from Google to Hepsiburada
  As a buyer
  I want to be able to navigate to hepsiburada from google
  So that I can purchase items

  @359 @merchant_disabled
  Scenario: Google a hepsiburada item and open it
    Given I make a google search with "hepsiburada sony playstation"
    When I click on google result no "1"
    Then I don't get the error page