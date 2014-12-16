# encoding: UTF-8
Given(/^I have an empty cart$/) do
  url = current_url
  click_link "shoppingCart"
  click_link "clearCart"
  visit url
end

Given /^I select a product with SKU (.*)$/ do |sku|
  steps %{
    Given I am on the homepage
    Given I search for "#{sku}"
    Given I select a product from search results
  }
end

When /^I add to cart$/ do
  within "#addToCartForm" do
    click_button "addToCart"
  end
end

When(/^I click 'go to cart'$/) do
  click_link 'shoppingCart'
end

When(/^I click 'add one more'$/) do
  click_button 'addToCartAgain'
end

When(/^I click on the returns policy link$/) do
  click_link 'productReturnPolicy'
end

When /^I make the page half as wide/ do
  window_size = Capybara.page.driver.browser.manage.window.size
  Capybara.page.driver.browser.manage.window.resize_to(window_size[0]/2, window_size[1])
end

When /^I load the page on a 1280x1024 monitor/ do
  Capybara.page.driver.browser.manage.window.resize_to(1280, 1024)
end

And /^I enter a quantity of (.*)$/ do | item_quantity |
  fill_in 'quantity', with: item_quantity
end

Then /^I should see the product in the cart$/ do
  expect(find('.cart-item', :count => 1))
  expect(find('.cart-item').text have_content @product_name)
end

Then(/^I should see (\d+) of the product in the cart$/) do |num|
  steps %{
      Given I should see the product in the cart
  }
  expect(find('.cart-item .quantity').text).to eq num
end

Then(/^I should see the notification$/) do
  wait_for_visibility(page, '#notification', true)
  wait_for_visibility(page, '#notification', false)
end

Then(/^I should see the 'go to cart' button$/) do
  wait_for_visibility(page, '#linkToCart', true)
end

Then(/^I should see the 'add one more' button$/) do
  wait_for_visibility(page, '#addToCartAgain', true)
end

Then(/^I should see an empty cart$/) do
  set_wait_time 5
  expect(page).to_not have_selector '.cart-item'
  revert_to_default_wait_time
end

Then(/^I see the details page for the selected product$/) do
  expect(page.find('#product-name').text).to eq @product_name
end

Then(/^I see a result with product price and tax$/) do
  expect(first(".product-price"))
end

Then(/^the page title contains the product name$/) do
  expect(page.title).to include(@product_name)
end

Then(/^I see at least (\d+) reviews$/) do |num|
  wait_for_visibility(page, '.review-item', true)
  expect(all('.review-item').count).to be >= num.to_i
end

Then(/^I can see the 'More Reviews' button$/) do
  expect(find('#showMoreComments'))
end

Then(/^I see to link to view the returns policy$/) do
  expect(find('#productReturnPolicy'))
end

Then(/^I see the returns policy$/) do
  expect(find('#productReturnPolicyText'))
end

Then(/^I see the super fast delivery flag$/) do
  # nb: 'per H' is standing in for 'Süper Hızlı' as couldn't work out
  # how to match encoded string correctly
  expect(first('#fastShipping').text).to match 'Süper Hızlı, Bugün Teslimat'
end

Then(/^I see the product information$/) do
  expect(find_by_id("offering-price"))
  expect(first("img.product-image")['src']).to match /jpg/
  expect(all('img.product-image').count).to be > 1
  expect(find_by_id('productDetailsCarousel'))
  expect(find_by_id('tabProductDesc'))
  expect(find('.detail-main .product-rating'))
end

Then(/^I see the option to select a variant with prices$/) do
  variant_container = find('.variant-container-with-prices')
  all_price_labels = variant_container.all('.price-label')
  expect(all_price_labels.count).to be > 1
  expect(variant_container).to have_selector('input')
end

Then(/^I see no variant with prices is selected$/) do
  variant_container = find('.variant-container-with-prices')
  set_wait_time 5
  variant_container.all('input[type=radio]').each do | radio_button |
    radio_button.should_not be_checked
  end
  revert_to_default_wait_time
end

Then(/^I see an error message asking me to make a selection$/) do
  wait_for_visibility(page, 'div #notification', true)
end

When(/^I select the first variant with price$/) do
  @URL = current_url
  all('.variant-container-with-prices .price-label').first.click
end

Then(/^I see the the variant with price is checked$/) do
  variant_container = find('.variant-container-with-prices')
  expect(variant_container.all('input[type=radio]').first).to be_checked
end

Then(/^I view the payment installments information$/) do
  first('#productPaymentInstallment').click
end

Then(/^I see at least one payment installment table$/) do
  all('.paymentInstallmentTable', :minimum => 1)
end

Then(/^I can view the product tech specs$/) do
  first('#productTechSpec').click
  all('.tech-spec', :minimum => 1)
end

Then(/^I see text indicating that free shipping is available$/) do
  expect(find('#fastShipping').text).to match "Kargo Bedava"
end

Then(/^I see the original price (.*) on the product with sku (.*)$/) do | price, sku |
  find_by_id(sku).should have_content price
end

Then(/^I see the original price (.*) on the product details page$/) do | price |
  find('del#originalPrice').should have_content price
end

Then(/^I see product return information specific to media/) do
  find_by_id('productReturnPolicyText').should have_content("İncelediğiniz ürün, Mesafeli Sözleşmelere Dair Yönetmeliğin 7.")
end

And(/^I see the discount percentage of (.*)$/) do | discount |
  find('#product-discount-rate del').should have_content discount
end

Then(/^I do not see a discount price$/) do
  page.should have_css('del#originalPrice', :visible => :hidden)
end

Then(/^there are (\d*) variants displayed$/) do | number |
    within('.product-variants-wrapper') do
      page.all('.select-styled').count.should eql(number.to_i)
    end
  end

And(/^the variants should have no default$/) do
  page.all('.radio-variant').each do | variant |
    set_wait_time 5
    variant.should_not be_checked
    revert_to_default_wait_time
  end
end

And(/^I see the discount percentage$/) do
  expect(find('#product-discount-rate'))
end

Then /^I see the cart item count is (.*)/ do | cart_quantity_count |
  page.find_by_id('cartItemCount').should have_content(cart_quantity_count)
end

Then (/^I should see (\d*) color variants$/) do | color_count |
  all('.question').first.should have_content("renk")
  variant_container = all('.variant-container').first
  variant_container.all('div').count.should eql(color_count.to_i)	
end

And /^I see the default product image$/ do
  @default_image_src = page.find('.owl-item.active').find('.product-image')['src']
end

And /^I wait for all Ajax requests to complete/ do
  loop until page.evaluate_script('jQuery.active').zero?
end

When(/^I select the color (.*)/) do | color |
  page.find('label', :text=> color).click
end

Then /^I see a different image$/ do
  new_image = page.find('.owl-item.active').find('.product-image')['src']
  set_wait_time 5
  expect(@default_image_src).to_not eq(new_image)
  revert_to_default_wait_time
end

Then /^I see no horizontal scroll bar/ do
  scroll_bar_present = page.execute_script("return document.documentElement.scrollWidth>document.documentElement.clientWidth;");
  expect(scroll_bar_present).to eq(false)
end

AfterStep('@658') do
  Capybara.page.driver.browser.manage.window.maximize
end

When /^I select the value (.*) from the (.*) dropdown$/ do | dropdown_value, dropdown_name |
  page.find_by_id(dropdown_name).find('option', :text=> dropdown_value).click
end

Then /^I see (.*) in the (.*) dropdown box$/ do | dropdown_value, dropdown_name |
  page.find_by_id(dropdown_name).value.should eq(dropdown_value)
end

And /^element with id (.*) is selected$/ do | variant_name |
  page.find_by_id(variant_name).should be_checked
end

Then /^I do not see the 'add to basket' button/ do
  set_wait_time 5
  expect(page).to_not have_selector('button.add-to-basket.button-like-link')
  revert_to_default_wait_time
end

Then /^I should see the bestseller section$/ do
  page.should have_selector('section.top-seller')
end

Then /^I should see the quantity box with a default of 1$/ do
  expect(page.find_by_id('quantity')[:value]).to eq "1"
end

Then(/^I should see a notification of (.*) items added to my basket$/) do | quantity |
  find_by_id('notification').should have_content(quantity + " Ürün başarılı bir şekilde sepete eklenmiştir.")
end

Then(/^I should see an invalid message notification$/) do
  find_by_id('notification').should have_content("Eklemek istediğiniz ürünün adedi geçerli değildir.")
end

Then /^I should see the installments section$/ do
  expect(find('#productPaymentInstallment'))
end

Then /^I should not see the installments section$/ do
  set_wait_time 5
  expect(page).to_not have_content('#productPaymentInstallment')
  revert_to_default_wait_time
end

Then /^I see a maximum of 10 products in the suggestions area$/ do 
  page.find_by_id('recommendedProductsCarousel').all('.owl-item').count.should <= 10
end

And /^I see a picture associated with each product$/ do
  page.find_by_id('recommendedProductsCarousel').all('.owl-item').each do | suggested_product |
    suggested_product.should have_selector('.product-image-wrapper')
  end
end

And /^when I select the first suggested product$/ do
  @product_url = current_url
  page.find_by_id('recommendedProductsCarousel').first('.product-image-wrapper').click
end 

Then /^I see the product details page$/ do
  new_product_url = current_url
  set_wait_time 5
  @product_url.should_not eq(new_product_url)
  revert_to_default_wait_time
end

Then /^I do not see suggestions$/ do
  set_wait_time 5
  expect(page).to_not have_content('.recommended-products-container')
  revert_to_default_wait_time
end

Then(/^I see a timer on product details page that shows when the deal ends$/) do
  expect(page.find('.sale-end-timer').text).should_not eq("")
  end

Then(/^Add to cart button is not available on product details$/) do
  div = find('div.product-price-wrapper')
  div.should have_content "Bu ürün geçici olarak temin edilememektedir."
  div.should have_selector("#addToCart", visible: :hidden)
end

And(/^I am able to select different variants$/) do
  div = find('div.variant-container-with-prices')
  i = div.all('label').size
  for i in 1..size
    div.find('div.label', match: :first)
    div.all('label')[i-1].click
  end
end

Then(/^Cart icon should have an indication of "([^"]*)"$/) do |arg|
  find_by_id('cartItemCount').text.to_i.should == arg.to_i
end

Then(/^I should not be able to add to cart without a variant$/) do
  fill_in "quantity", :with=> 1
  find_by_id("addToCart").click
  page.should have_content("Lütfen bir seçim yapınız.")
  page.should have_selector("#notification", visible: :hidden)
end

And(/^There are "([^"]*)" comments on details$/) do |arg|
  div = find_by_id('reviews')
  div.find('li.review-item', match: :first)
  comments = div.all('li.review-item')
  comments.size.should == arg.to_i
end

And(/^I click on more comments button$/) do
  find_by_id('showMoreComments').click
end

When(/^I click return policy link$/) do
  find_by_id('productReturnPolicy').click
end

Then(/^I get the return policy description$/) do
  find_by_id('returnPolicy').should have_content('İade Koşulları')
end

When(/^I click product description tab$/) do
  find_by_id('productDescription').click
end

Then(/^I get the product description$/) do
  find_by_id('tabProductDesc')
end

When(/^I click product specs tab$/) do
  find_by_id('productTechSpec').click
end

Then(/^I get the product specs$/) do
  find_by_id('tabTechSpec')
end

And(/^I should be able to visit every link on breadcrumb trail$/) do
  links = find('ul.breadcrumbs').all('li[itemtype="http://data-vocabulary.org/Breadcrumb"]').collect{|x| x.first('a')['href']}
  links.each { |x|
    visit x
    steps %{ Then I don't get the error page }
  }
end

Then(/^I don't see a text indicating that free shipping is available$/) do
  page.should have_no_content "Kargo Bedava"
end

And(/^I see the number of reviews$/) do
  count = find('span[itemprop="reviewCount"]').text.to_i
  count.should > 0
end

And(/^There are no comments on details$/) do
  page.should have_no_selector "#reviews"
end

Then(/^There is no installment option for this product$/) do
  find_by_id('productPaymentInstallment').click
  div = find_by_id('tabPaymentInstallment')
  div.should have_content "Yeni yasal düzenleme gereği; telekomünikasyon, kuyum, yemek ve gıda alımlarında 1 Şubat 2014 itibariyle taksit uygulanamamaktadır."
  div.find('img[alt="Taksit Yok"]')
end

Then(/^I don't see the super fast delivery flag$/) do
  page.should have_no_selector "#fastShipping"
end

Then(/^I should see the stored image in product details$/) do
  link = find_by_id('productDetailsCarousel').find('div.owl-item.active').find('img')['src']
  link.include?($file_name).should == true
end

Then(/^There are multiple images in details$/) do
  div = find_by_id('productDetailsCarousel')
  div.find('div.owl-item', match: :first)
  size = div.all('div.owl-item').size
  size.should > 1
end

And(/^I cycle through thumbnails in details$/) do
  div = find_by_id('productDetailsCarousel')
  div.find('div.owl-item', match: :first)
  size = div.all('div.owl-item').size
  (size - 1).times do
    find('div.owl-next').click
    sleep 1
  end
  (size - 1).times do
    find('div.owl-prev').click
    sleep 1
  end
  all('div.owl-dot').each { |x|
    x.find('img').click
    sleep 1
  }
end

Then(/^There is only one image in details$/) do
  div = find_by_id('productDetailsCarousel')
  div.find('div.owl-item', match: :first)
  size = div.all('div.owl-item').size
  size.should == 1
end

Then(/^Product title is displayed in details$/) do
  page.should have_content $p_title
end

Then(/^Product sku is contained in the url$/) do
  page.current_url.include?($p_id).should == true
end