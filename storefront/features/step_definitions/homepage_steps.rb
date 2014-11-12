@page = ""

Given /^I am on the homepage$/ do
  @page = Pages::Homepage.visit
end

Given(/^I see the first level navigation bar/) do
  page.should have_selector('.browser-by-category')
  expect(find('.browser-by-category').text).to include "Elektronik Beyaz Eşya"
  expect(find('.browser-by-category').text).to include "Ev, Yaşam Ofis"
  expect(find('.browser-by-category').text).to include "Oto, Bahçe Yapı Market"
end

Then(/^I see deal of the day$/) do

end

Then(/^I see (\d+) items in deal of the day$/) do |items|
  expect(all("#dealOfTheDayCarousel li a").count.to_s).to eq items
end

Then(/^each deal of the day product shows its undiscounted price/) do
  expect(page.all("#dealOfTheDayCarousel li .product-price-wrapper"))
  .to all_satisfy(have_selector(".product-old-price"))
end

When(/^I visit the computers category landing page/) do
  page.first('.browser-by-category a').click
  page.first('.nav-home-wrapper .nav-home a').click
end

When(/^I hover over the (.*) navigation bar entry/) do | navigation_name |
  page.find_link(navigation_name).hover
end

When(/^I click on the link (.*)/) do | link |
  page.find(:xpath, "//a[@href=\"" + link + "\"]").click
end

Then(/^I see the page with the title (.*)/) do | expected_title |
  expect(page).to have_title expected_title
end

Then(/^I visit the telephones category page$/) do
  page.first('.browser-by-category a').click
  page.all('.nav-home-wrapper .nav-home a')[1].click
end
