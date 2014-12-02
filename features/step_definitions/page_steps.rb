When(/^I click the feedback button$/) do
  click_button 'btnSendFeedback'
end

When /^I search for "(.*)"$/  do | search_term |
  fill_in 'productSearch', :with => "#{search_term}"
  page.find_by_id('buttonProductSearch').click
  @total_items = page.find_by_id('totalItems').text
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
  expect(find('footer .icon-linkedin'))
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