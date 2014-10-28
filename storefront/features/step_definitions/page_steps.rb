When(/^I click the feedback button$/) do
  click_button 'btnSendFeedback'
end

Then(/^I see a feedback window$/) do
  sleep(1)
  within_frame all('div iframe').last do
    expect(page.find('#usabilla-choice-container'))
  end
end

When(/^I reload the page$/) do
  pending
end