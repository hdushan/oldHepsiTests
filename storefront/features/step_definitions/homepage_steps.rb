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
  deal_of_the_day_carousel = find_by_id('dealOfTheDayCarousel')
  expect(deal_of_the_day_carousel.all('.grid-item').count.to_s).to eq items
end

Then(/^each deal of the day product shows its undiscounted price/) do
  expect(page.all("#dealOfTheDayCarousel li .product-price-wrapper"))
  .to all_satisfy(have_selector(".product-old-price"))
end

When(/^I visit the computers category landing page/) do
  page.first('.browser-by-category a').click
  page.first('.nav-home-wrapper .nav-home a').click
end

When(/^I hover over the first navigation bar entry/) do
  page.first('.browser-by-category li a').hover
end

When(/^I click on the link (.*) in the active second level/) do | link |
  page.find('.browser-by-category li.active .nav-home-wrapper').find(:xpath, "//a[@href=\"" + link + "\"]").click
end

Then(/^I see the page with the title (.*)/) do | expected_title |
  expect(page).to have_title expected_title
end

Then(/^I visit the telephones category page$/) do
  page.first('.browser-by-category a').click
  page.all('.nav-home-wrapper .nav-home a')[1].click
end

Then(/^I can see the second level categories/) do
  expect(page).to have_selector('.browser-by-category li.active .nav-home-wrapper')
end

When(/^I see the fly-out menu$/) do
  expect(page.find('.browser-by-category li.active .nav-home-wrapper')).to have_selector('.flyout-campaign-wrapper')
end

Then(/^I can see at least (\d) static banners/) do | minimum_number_of_static_banners |
  expect(all('.static-banners li').count).to be >= minimum_number_of_static_banners.to_i
end