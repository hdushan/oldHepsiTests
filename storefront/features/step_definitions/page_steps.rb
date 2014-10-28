When(/^I click the feedback button$/) do
  click_button 'btnSendFeedback'
end

When /^I search for (.*)$/  do | search_term |
  fill_in 'productSearch', :with => "#{search_term}"
  click_button "buttonProductSearch"
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