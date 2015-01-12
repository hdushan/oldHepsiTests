#encoding: UTF-8
Given(/^I see the first level navigation bar with 9 categories/) do
  page.should have_selector('.browser-by-category')
  expect(page.all('.browser-by-category li.force-two-line').count.to_i).to eq(7)
  expect(page.all('.browser-by-category li.first-child').count.to_i).to eq(1)
  expect(page.all('.browser-by-category li.last-child').count.to_i).to eq(1)
end

Given /^I navigate to the second level category tablet computers$/ do
  steps %{
    When I hover over the electronic appliances navigation bar entry
    When I click on the second level category tablet computers
  }
end
Given /^I navigate to the RAM sub-category/ do
  steps %{
    Given I navigate to the second level category tablet computers
    When I click on the computer components category
    And I select the RAM sub-category
  }
end

When(/^I hover over the electronic appliances navigation bar entry/) do
  cat1 = find('ul.browser-by-category').first('li', :text=> 'Elektronik Beyaz Eşya')
  cat1.click
  find('.navigation ul.menu > li:hover')
end

When(/^I click on the computer components category/) do
  expect(page.find('.nav-browse')).to have_content('Bilgisayar Bileşenleri')
  page.find('.nav-browse').find('a', :text => 'Bilgisayar Bileşenleri').click
end

And(/^I select the RAM sub-category/) do
  computer_components_submenu = page.find('.page-options').find_by_id('8')
  expect(computer_components_submenu).to have_content('Bellek (Ram)')
  computer_components_submenu.find('a', :text=>'Bellek (Ram)').click
end

Then(/^I can see the second level categories/) do
  expect(page).to have_selector('.browser-by-category li:hover .nav-home-wrapper', visible: :visible)
end

Then(/^I can see the third level categories/) do
  expect(page.find('.nav-browse').all('.secondLevelContainer').count).to be >= 8
end

Then(/^I can see the RAM breadcrumb/) do
  expect(page.find_by_id('breadcrumbFor-47')).to have_content('Bellek (Ram)')
end

When /^I click the breadcrumb with ID (.*)/ do | element_id |
  page.find_by_id(element_id).click
end

Then(/^I see thumbnails on carousel$/) do
  thumbs = find_by_id('carousel').find('.owl-dots').all('.owl-dot')
  thumbs.each { |x|
    x.find('img', match: :first)
  }
end

Then(/^I should see the counter on deal of the day items$/) do
  carousel = find_by_id('dealOfTheDayCarousel')
  back = carousel.find('.owl-prev')
  forward = carousel.find('.owl-next')
  while back['class'].include?('disabled') == false
    back.click
    sleep 1
  end
  while forward['class'].include?('disabled') == false
    items = carousel.all('.owl-item.active')
    items.each { |x|
      x.should have_selector('.sale-end-timer-days', text: "Gün")
      x.should have_selector('.sale-end-timer-hours', text: "Saat")
      x.should have_selector('.sale-end-timer-minutes', text: "Dk")
    }
    forward.click
    sleep 1
  end
  items = carousel.all('.owl-item.active')
  items.each { |x|
    x.should have_selector('.sale-end-timer-days', text: "Gün")
    x.should have_selector('.sale-end-timer-hours', text: "Saat")
    x.should have_selector('.sale-end-timer-minutes', text: "Dk")
  }
end