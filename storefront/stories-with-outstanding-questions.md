#### If questions have been answered please put the story back into the TODO file ####

@460: Transform "Add to Basket" button to "Finish Shopping" on click
This no longer happens when a user clicks add to basket, has this functionality been reverted or is this a regression?

@316: Show USD prices in results pages with campaigns properly
We need a product that's not in Turkish Lira, however tests for #315 (Display non-TL prices) was rejected because all 
the non-TL prices aren't converted. Does this test still stand?

@386: Add "#" at the end of URL when sorting for better site crawlability
How does adding "#" to a URL increase SEO and how can we test this? Do we just test the URL and how much value will 
this bring?

Webtrekk
@614 @storefront Feature: Webtrekk for beta
@673: Do not send Turkish characters as part of webtrekk
@638 @storefront Feature: Update Webtrekk Implementation

Most of these stories would be tested by loading pages and asserting that a specific script is present, do you want this?
How do we test 3rd party software like Webtrekk and Google Analytics?

@700: Update discount when choosing among variants that differ by price
Is it feasible to select two different products and then test that the discount prices are different?

@70: Display Price Dependent Variants on Details Page
Do we write tests which include access to the Manager Query tool? 

@484: Opt-in and Opt-out for beta in internal network
Further clarification needed (not seeing beta opt in on VPN at the moment)

@418: Distinguish non-valid combinations of variants on product details page
CSS bug raised on this story. Can this test be done now?

@342: Display next available variant on results page
This involves testing the old site as well, can this be done?

Story number unknown
There is a test that attempts to add an item to the basket and then press a button "add another one", this test is 
currently failing as there is no "add another one" button, has this button been removed or is this a regression?

Cart in QA
As of 1700 today (24/11/2014) the cart in QA no longer points to the stub implementation 
(http://storefront.qa.hepsiburada.com:97//cart/index), instead, it links to the what I assume is in the real cart 
(https://www.hepsiburada.com/ayagina-gelsin/sepetim?_ga=1.230487068.1636013589.1415623086) . Is this intentional? 
The cart tests will now fail, want to be sure this is the new cart implementation before refactoring all of the cart 
tests.

Performance Issues
Some tests fail such as Story 42 (detailed in email to be forwarded on), because the capybara timeout for Ajax requests 
is too short (currently set at 5 seconds). Whilst I accept our Ajax requests should not be taking near 5 seconds, we 
could increase the timeout and ensure that tests pass to assert the functionality is correct (even if a little slow), 
this way we should catch any genuine failures and not get performance related failures. Do you want us to take this path 
or should we leave the limit as it is and wait on a fix to the performance issues? 