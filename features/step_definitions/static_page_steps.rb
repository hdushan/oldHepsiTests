Given(/^I visit a static page with id "(.*?)"$/) do |page_id|
  visit "/staticPage/#{page_id}"
end

Then(/^I see the static page with title "(.*?)" and canonical link "(.*?)" and content "(.*?)"$/) do |title, canonical_link, content|
  set_wait_time 5
  expect(page).to have_title(title)
  within("head", visible: false) do
    expect(find('link[rel="canonical"]')['href']).to include(canonical_link)
  end
  expect(page).to have_content(content)
  revert_to_default_wait_time
end