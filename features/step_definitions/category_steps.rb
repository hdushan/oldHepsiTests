#encoding: UTF-8

And /^I click the bestsellers tab/ do
  find_by_id('bestSelling').click
end

When(/^I click on SEO link$/)do
  click_link('showCategoryInfo')
end

Then(/^I see a pop up with category title and some SEO text$/) do
  page.should have_selector('#categoryTitle')
  page.should have_content('Bilgisayar Fiyatları ve Modelleri')
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