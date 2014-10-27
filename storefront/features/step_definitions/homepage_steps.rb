@page = ""

Given /^I am on the homepage$/ do
  @page = Pages::Homepage.visit
end

When /^I searched for (.*)$/  do | search_term |
  fill_in 'q', :with => "#{search_term}"
  click_button "buttonProductSearch"
end

Then(/^I see deal of the day$/) do

end

Then(/^I see (\d+) items in deal of the day$/) do |items|
  expect(all("#dealOfTheDayCarousel li a").count should equal? items)
end

When(/^I click the feedback button$/) do
  click_button 'btnSendFeedback'
end

Then(/^I see a feedback window$/) do
    within_frame all('div iframe').last do
    expect(page.find('#usabilla-choice-container'))
  end
end