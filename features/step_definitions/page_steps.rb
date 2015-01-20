#encoding: UTF-8
Given /^I navigate to the computers category landing page/ do
  visit_link 'http://storefront.qa.hepsiburada.com/bilgisayar-c-2147483646'
end

Then /^I see an indicator of free shipping associated with at least one item/ do
  expect(page.find_by_id('productresults', :visible => true)).to have_content('Kargo Bedava')
end

When(/^I click the feedback button$/) do
  click_button 'btnSendFeedback'
end

When /^I search for "(.*)"$/  do | search_term |
  fill_in 'productSearch', :with => search_term
  page.find_by_id('buttonProductSearch').click
  if search_term.strip != ""
    if page.has_selector?('#totalItems')
      $current_results = extract_number find_by_id('totalItems').text
    end
  end
end

Then(/^I see a feedback window$/) do
  sleep(1.5)
  within_frame all('div iframe').last do
    expect(page.find('#usabilla-choice-container'))
  end
end

When(/^I reload the page$/) do
  visit current_url
end

When(/^I clear the browsers cookies$/) do
  browser = Capybara.current_session.driver.browser
  browser.manage.delete_all_cookies
end

Then(/^I see the social icons in the footer$/) do
  expect(find('footer .icon-facebook'))
  expect(find('footer .icon-twitter'))
  expect(find('footer .icon-google-plus'))
  expect(find('footer .icon-pinterest'))
  expect(find('footer .icon-instagram'))
  expect(find('footer .icon-youtube'))
end

Then(/^I see the security logo in the footer$/) do
  expect(find('footer .icon-security-link'))
end

Then(/^I see the copyright message in the footer$/) do
  expect(find('footer .copyright'))
end
