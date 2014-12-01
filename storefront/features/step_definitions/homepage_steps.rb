# encoding: UTF-8

@page = ""

Given /^I am on the homepage$/ do
  @page = Pages::Homepage.visit
  @homepage_url = current_url
end

Given /^I click on the first banner thumbnail/ do
  page.find_by_id('carousel').find('.owl-dots').all('.owl-dot').first.click
end

And /^I see the first banner/ do
  @first_banner_src = page.find_by_id('carousel').find('.owl-item.active').find('.product-image')['src']
end

When /^I click on the second thumbnail/ do
  page.find_by_id('carousel').find('.owl-dots').all('.owl-dot')[1].click
end

Then /^I see a different banner/ do
  second_banner = page.find_by_id('carousel').find('.owl-item.active').find('.product-image')['src']
  expect(@first_banner_src).to_not eq(second_banner)
end

Then(/^I see (\d+) items in deal of the day$/) do |items|
  page.find_by_id('dealOfTheDayCarousel').all('.owl-item').count.should eq(items.to_i)
end

Then(/^each deal of the day product shows its undiscounted price/) do
  page.find_by_id('dealOfTheDayCarousel').all('.owl-item').each do |deal|
      deal.should have_selector('.product-old-price')
  end
end

When /^I click on the current banner/ do
  page.first('.owl-item.active').find('.product-image').click
end

Then /^I am no longer on the homepage/ do
  current_url.should_not eq(@homepage_url)
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

Then(/^I see banners of size 900x370/) do
  carousel_item = page.find_by_id('carousel').first('.owl-item')
  carousel_item.native.css_value('width').should eq('900px')
  carousel_item.native.css_value('height').should eq('370px')
end

Given /^I have input (.*) into search$/ do | search_term |
  fill_in 'productSearch', :with => search_term
end

Then /^I see no suggestions based on my inputs$/ do
  page.find('.autocomplete-suggestions')['style'].should include('display: none')
end

Then /^I see (\d+) categories and (\d+) other keywords$/ do | category_number, keyword_number |
  total_of_search_terms = category_number.to_i + keyword_number.to_i
  expect(page).to have_selector('.autocomplete-suggestion', count:total_of_search_terms)
end

And /^I see suggestions based on (.*)$/ do | search_term |
  page.find('.autocomplete-suggestions').all('.autocomplete-suggestion').each do | suggestion |
      expect(suggestion.text).to match(/#{search_term}/i)
  end
end 