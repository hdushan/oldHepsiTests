@page = ""

Given /^I am on the homepage$/ do
  @page = Pages::Homepage.visit
end

When /^I searched for (.*)$/  do | search_term |
  fill_in 'q', :with => "#{search_term}"
  click_button "buttonProductSearch"
end