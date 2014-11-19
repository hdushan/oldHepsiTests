# encoding: UTF-8

@page = ""

Given /^I am on the homepage$/ do
  @page = Pages::Homepage.visit
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

Then(/^I see the page with the title (.*)/) do | expected_title |
  expect(page).to have_title expected_title
end

Then(/^I visit the telephones category page$/) do
  page.first('.browser-by-category a').click
  page.all('.nav-home-wrapper .nav-home a')[1].click
end

When(/^I see the fly-out menu$/) do
  expect(page.find('.browser-by-category li.active .nav-home-wrapper')).to have_selector('.flyout-campaign-wrapper')
end

Then(/^I can see at least (\d) static banners/) do | minimum_number_of_static_banners |
  expect(all('.static-banners li').count).to be >= minimum_number_of_static_banners.to_i
end
