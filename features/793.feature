#encoding: UTF-8

@loginlogout
Feature: 793 - Log in and log out 
  As a Hepsiburada customer
  I want to log in and log out of the site via Storefront instead of www.hepsiburada.com
  So that I enjoy an uninterrupted browsing experience

  Scenario: See action to log in from anywhere in Storefront
    Given I am logged out
    When I view any page in Storefront
    Then I see an action to log in

  Scenario: Log in
    Given I’d like to access my account
    When I invoke the action to log in
    Then I am taken to the existing site (hepsiburada.com’s) log in page where I may enter in my username and password

  Scenario: After logging in via SF, take the user back to the SF page they were on 
    Given I have invoked the action to log in from Storefront page X
    And I have entered my valid username and password combination on the log in page
    When I invoke the action to log in from the log in page
    Then I am taken back to the page that I came from in Storefront
    And I see an action to log out from any page in Storefront

  Scenario: If there were no items in basket before I logged in, show me the saved contents of my basket
    Given I am logged out and have no items in basket
    And in a previous session, I was logged in and had added items to my basket
    When I log in again successfully
    Then I see the items that had been added to my basket appear in my basket again

  Scenario: If there were items in basket before I logged in, they replace any previous contents note: this is not the ideal outcome
    Given I am logged out and have some items in basket
    And in a previous session, I was logged in and had added items to my basket
    When I log in again successfully
    Then I see the items from my logged-out session
    And I do not see the old items that used to be in my basket

  Scenario: My account and my orders should still prompt user to log in and afterward, take them to the hepsiburada.com page note: this is happening today already
    Given I am logged out
    When I invoke the action to access my account or my orders
    Then I am prompted to log in
    And after I log in
    Then I am taken to my account or my orders (whichever I had selected) on the existing hepsiburada.com
    And I am not taken back to Storefront by default

  Scenario: After being logged in, going to my account and my orders should no longer require log in
    Given I am logged in
    When I invoke the action to access my account or my orders
    Then I not prompted to log in
    And I am taken to my account or my orders (whichever I had selected) on the existing hepsiburada.com

  Scenario: Log out
    Given I am logged
    When I invoke the action to log out from a page on Storefront
    Then I am logged out of the site
    And I am remain on the same page
    And my basket reflects no items
