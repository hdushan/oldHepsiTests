Given(/^I visit a static page with id "(.*?)"$/) do |page_id|
  visit_link "/staticPage/#{page_id}"
end

Then(/^I see the static page with title "(.*?)" and canonical link "(.*?)" and content "(.*?)"$/) do |title, canonical_link, content|
  expect(page).to have_title(title)
  within("head", visible: false) do
    expect(find('link[rel="canonical"]')['href']).to include(canonical_link)
  end
  expect(page).to have_content(content)
end

When(/^There are "([^"]*)" static banners on homepage$/) do |arg|
  i = arg.to_i
  page.find('ul.static-banners', match: :first)
  all('ul.static-banners').size.should == i
end

Then(/^I should be able to visit every static banner$/) do
  page.find('ul.static-banners', match: :first)
  links = all('ul.static-banners').collect{|x| x.first('a')['href']}
  links.each { |x|
    visit_link  x
    steps %{ Then I don't get the error page }
  }
end