@page = ""

Given /^I am on the homepage$/ do
  @page = Pages::Homepage.visit
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

Then(/^I visit the telephones category page$/) do
  page.first('.browser-by-category a').click
  page.all('.nav-home-wrapper .nav-home a')[1].click
end
