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
  set_wait_time 5
  expect(@first_banner_src).to_not eq(second_banner)
  revert_to_default_wait_time
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

Then(/^I see banners with a width of (\d+) and a height of (\d+)/) do | expected_width, expected_height |
  banner_width = page.evaluate_script("$(\"img[src*='http://images.hepsiburada.net/assets/ThematicContent/Mobil/desktopsite']\")[0].width")
  banner_height = page.evaluate_script("$(\"img[src*='http://images.hepsiburada.net/assets/ThematicContent/Mobil/desktopsite']\")[0].height")
  banner_width.should be > expected_width.to_i
  banner_height.should be > expected_height.to_i
end

Given /^I have input (.*) into search$/ do | search_term |
  fill_in 'productSearch', :with => search_term
end

Then /^I see no suggestions based on my inputs$/ do
  expect(page).to have_selector('.autocomplete-suggestions', :visible => false)
end

And /^I see (\d+) categories and (\d+) other keywords$/ do | category_number, keyword_number |
  total_of_search_terms = category_number.to_i + keyword_number.to_i
  expect(page).to have_selector('.autocomplete-suggestion', count:total_of_search_terms)
end

When /^I press the down arrow/ do
  find_by_id('productSearch').native.send_keys :arrow_down
end

Then /^I see suggestions based on (.*)$/ do | search_term |
  page.find('.autocomplete-suggestions', :visible => true).all('.autocomplete-suggestion').each do | suggestion |
    expect(suggestion.text).to match(/#{search_term}/i)
  end
end

Then /^I see updated suggestions based on (.*)$/ do | search_term |
  page.find('.autocomplete-suggestions').all('.autocomplete-suggestion').each do | suggestion |
    expect(suggestion.text).to match(/#{search_term}/i)
  end
end

Given /^I append (.*) into search$/ do | search_term | 
   find_field('productSearch').native.send_keys(search_term)
end

Then /^I see a visual indication that an auto complete suggestion is selected/ do
  first_auto_complete_suggestion = find('.autocomplete-suggestions').first('.autocomplete-suggestion')
  expect(first_auto_complete_suggestion.native.style('background-color')).to eq('rgba(233, 233, 233, 1)')
end

Given /^I see no visual indication of auto complete selection/ do
  find('.autocomplete-suggestions').all('.autocomplete-suggestion').each do | auto_complete_suggestion |
    expect(auto_complete_suggestion.native.style('background-color')).to eq('rgba(255, 255, 255, 1)')
  end
end

Given /^I see the auto complete suggestions/ do
  expect(page).to have_selector('.autocomplete-suggestions', :visible => true)
  @initial_auto_complete_suggestions = page.find('.autocomplete-suggestions').first('.autocomplete-suggestion').text
end

And /^I wait for auto complete results to update/ do
  Timeout.timeout(Capybara.default_wait_time) do
    loop until page.find('.autocomplete-suggestions', :visible => true).first('.autocomplete-suggestion', :visible => true).text != @initial_auto_complete_suggestions
  end
end

When /^I click on the first search suggestion/ do
  page.find('.autocomplete-suggestions', :visible => true).first('.autocomplete-suggestion', :visible => true).click
  sleep 10
end

Then /^I see products relating to (.*)/ do | key_term |
  page.all('.search-item').each do | search_item |
    search_item.find('.product-title').text.should match(/#{key_term}/i)
  end
end

And /^I do not like any of the auto complete suggestions/ do
end

When /^I invoke search on my own keywords/ do
  find_by_id('productSearch').native.send_keys :enter
end

Then /^I am taken to results based on my own keyword (.*)/ do  | key_term |
  page.all('.search-item').each do | search_item |
    search_item.find('.product-title').text.should match(/#{key_term}/i)
  end
end

Then(/^I see link "(.*?)" that navigates to "(.*?)" in a "(.*?)" if required and with the right SEO attribute "(.*?)"$/) do |link_text, link, new_tab, seo_attribute|
  div = find('div.footer-middle')
  #temp = div.find('a', :text => link_text, :exact => true)
  temp = div.find('a', :text => /\A#{Regexp.quote(link_text)}\z/)
  expect(temp['href']).to include(link)
  if new_tab =="Y"
    expect(temp['target']).to eq("_blank")
  else if new_tab =="N"
         set_wait_time(5)
         expect(temp).to_not have_content(['_blank'])
         revert_to_default_wait_time
       end
  end
  if seo_attribute=="Y"
    expect(temp['rel']).to eq("nofollow")
  else if seo_attribute =="N"
         set_wait_time(5)
         #expect(temp).to_not have_content(['nofollow'])
         expect(temp).to_not have_content(['nofollow'])
         revert_to_default_wait_time
       end
  end
end

Then(/^The page title is "([^"]*)"$/) do |arg|
  page.title.should == arg
end

And(/^I open deal of the day no "([^"]*)"$/) do |arg|
  i = arg.to_i - 1
  unless i<0
    page.all('#dealOfTheDay .product a')[i].click()
  end
end


Then(/^Favicon should be on page$/) do
  path = "/Content/images/favicon.ico"
  find('head').find("link[href='#{path}']", )
end

Then(/^Favicon should be on mobile page$/) do
  path = "/m/Content/images/favicon.ico"
  find('head').find("link[href='#{path}']", )
end

And(/^Deal of the day items have titles$/) do
  items = find_by_id('dealOfTheDayCarousel').all('div.owl-item')
  items.each{ |x|
    title = format_price x.find('h3.title').text
    title.should_not == nil
  }
end

Then(/^Discounted prices should be displayed in deal of the day items$/) do
  steps %{ Then Original prices should be displayed in deal of the day items }
end

Then(/^I should be able to visit every item in deal of the day carousel$/) do
  links = find_by_id('dealOfTheDayCarousel').all('div.owl-item').collect{|x| x.first('a')['href']}
  links.each{ |x|
    visit x
    steps %{ Then I don't get the error page }
  }
end