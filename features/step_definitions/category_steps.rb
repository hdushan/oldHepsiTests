#encoding: UTF-8

And /^I click the bestsellers tab/ do
  find_by_id('bestSelling').click
end

Then(/^I should see Fast Shipping offered for product "(.*?)"$/) do |product_name|
  matching_product=nil
  products = page.all("#productResult .product-detail")
  products.each do |curr_product|
    curr_product_name = curr_product.find("h3").text
    if curr_product_name == product_name
      matching_product=curr_product
      break
    end
  end
  matching_product.all(".shipping-status", :text=>/Süper Hızlı/).size.should == 1
end

Then(/^I should not see adult item "(.*?)" on CLP$/) do |adult_item_sku|
  page.find('#totalItems')
  set_wait_time 5
  find_by_id('productresults').should have_no_content (adult_item_sku)
  revert_to_default_wait_time
end

Then(/^There are some items with variant indication$/) do
  find('.search-item', match: :first)
  results = find_by_id('productresults').all('div.product-with-variant').select{|x| x['style'] != 'display: none;'}
  results.size.should > 0
  results.each { |x|
    x.should have_content('Bu ürünün farklı seçenekleri bulunmaktadır.')
    x.should have_no_selector('button.add-to-basket.button.small')
  }
end

Then(/^I see the category results message with category name "([^"]*)"$/) do |arg|
  title = find('header.container.title-wrapper')
  title.should have_content arg
  # title.should have_content "kategorisinde"
  # title.should have_content "ürün bulunmaktadır."
  (extract_number find_by_id('totalItems').text).to_i.should > 0
end

Then(/^I should be able to sort on CLP$/) do
  initial = find_by_id('productresults').all('.price-container').collect(&:text)
  find(".sort-wrapper .button").click
  find_by_id('sortResultsHeader').find('a', text: 'Akıllı sıralama')['class'].include?('selected').should == true
  find_by_id('sortResultsHeader').find('a', text: 'En düşük fiyat').click
  wait_for_ajax
  sleep 2
  find_by_id('sortResultsHeader').find('a', text: 'En düşük fiyat')['class'].include?('selected').should == true
  last = find_by_id('productresults').all('.price-container').collect(&:text)
  initial.should_not == last

  initial = find_by_id('productresults').all('.price-container').collect(&:text)
  find(".sort-wrapper .button").click
  find_by_id('sortResultsHeader').find('a', text: 'En yüksek fiyat').click
  wait_for_ajax
  sleep 2
  find_by_id('sortResultsHeader').find('a', text: 'En yüksek fiyat')['class'].include?('selected').should == true
  last = find_by_id('productresults').all('.price-container').collect(&:text)
  initial.should_not == last
end

Then(/^I should not see a filter for "([^"]*)"$/) do |arg|
  find('.FiltersList').all('h6').select{ |x| x.text =~ /#{arg}/i }.size.should == 0
end

Then(/^I some see upto (\d+) chars of the SEO text$/) do |arg|
  expect(page).to have_selector('#categoryInformation')
  expect(find_by_id('categoryTitle').text.length).to be > 0
  $original_length_of_seo_description = find_by_id('categoryDescription').text.length
  expect($original_length_of_seo_description).to be < arg.to_i
  expect(page).to have_selector('.see-more')
end

And(/^when I click on the view more link$/) do
  within('#categoryInformation') do
    all('.see-more').first.click
  end
end

Then(/^I see the full SEO test$/) do
  new_seo_description =  find_by_id('categoryDescription')
  expect(new_seo_description.text.length).to be > $original_length_of_seo_description
end