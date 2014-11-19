page = Homepage.new

When(/^I click the feedback button$/) do
  click_button 'btnSendFeedback'
end

When /^I search for (.*)$/  do | search_term |
  page.header.search_for(search_term)
end

Then(/^I see a feedback window$/) do
  sleep(1)
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
  page.footer.should have_social_links
end

Then(/^I see the security logo in the footer$/) do
  page.footer.should have_icon_security_link
end

Then(/^I see the copyright message in the footer$/) do
  page.footer.should have_copyright_message
end