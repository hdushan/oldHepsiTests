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

Then(/^each deal of the day product shows its undiscounted price/) do
  expect(page.all("#dealOfTheDayCarousel li .product-price-wrapper"))
  .to all_satisfy(have_selector(".product-old-price"))
end

When(/^I visit the computers category landing page/) do
  page.first('.browser-by-category a').click
  page.first('.nav-home-wrapper .nav-home a').click
end
