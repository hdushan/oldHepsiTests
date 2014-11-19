Given(/^I see the first level navigation bar/) do
  page.should have_selector('.browser-by-category')
  expect(find('.browser-by-category').text).to include "Elektronik Beyaz Eşya"
  expect(find('.browser-by-category').text).to include "Ev, Yaşam Ofis"
  expect(find('.browser-by-category').text).to include "Oto, Bahçe Yapı Market"
end

Given /^I navigate to the second level category tablet computers$/ do
  steps %{
    When I hover over the electronic appliances navigation bar entry
    When I click on the second level category tablet computers
  }
end

When(/^I hover over the electronic appliances navigation bar entry/) do
  page.find('.browser-by-category').find('a', :text=> 'Elektronik Beyaz Eşya').hover
end

When(/^I click on the second level category tablet computers/) do
  page.find('.browser-by-category li.active .nav-home-wrapper').find('a', :text=> 'Bilgisayar Tablet').click
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
  expect(page).to have_selector('.browser-by-category li.active .nav-home-wrapper')
end

Then(/^I can see the third level categories/) do
  expect(page.find('.nav-browse').all('.secondLevelContainer').count).to be >= 8
end

Then(/^I can see the RAM breadcrumb/) do
  expect(page.find_by_id('breadcrumbFor-47')).to have_content('Bellek (Ram)')
end