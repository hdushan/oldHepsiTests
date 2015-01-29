#encoding: UTF-8
Given(/^I have an empty cart$/) do
  url = current_url
  click_link "shoppingCart"
  click_link "clearCart"
  visit_link url
end

Given /^I select a product with SKU (.*)$/ do |sku|
  steps %{
    Given I am on the homepage
    Given I search for "#{sku}"
    Given I select a product from search results
  }
end

When /^I add to cart$/ do
  $p_quantity = find_by_id('quantity').value
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
  find_by_id('productReviewsTab').click
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
  expect(find('section.product-detail-container').find('#productReturnPolicyText'))
end

Then(/^I see the super fast delivery flag$/) do
  # nb: 'per H' is standing in for 'Süper Hızlı' as couldn't work out
  # how to match encoded string correctly
  find('.product-featured-details').all("img", visible:true).select{|x|
    x['src'].include?('super_hizli.png')
  }.size.should > 0
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
  find_by_id('productPaymentInstallment').click
  find('.paymentInstallmentTable', match: :first)
end

Then(/^I see at least one payment installment table$/) do
  all('.paymentInstallmentTable', :minimum => 1)
end

Then(/^I can view the product tech specs$/) do
  find('#productTechSpec').click
  all('.tech-spec', :minimum => 1)
end

Then(/^I see text indicating that free shipping is available$/) do
  find('.product-price-wrapper').find('span.free-shipping', visible: :true)
end

Then(/^I see the original price (.*) on the product with sku (.*)$/) do | price, sku |
  find_by_id(sku).should have_content price
end

Then(/^I see the original price (.*) on the product details page$/) do | price |
  find('del#originalPrice').should have_content price
end

Then(/^I see product return information specific to media/) do
  find('section.product-detail-container').find_by_id('productReturnPolicyText').should have_content("İncelediğiniz ürün, Mesafeli Sözleşmelere Dair Yönetmeliğin 7.")
end

And(/^I see the discount percentage of (.*)$/) do | discount |
  find('#product-discount-rate').should have_content discount
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

Then /^I see the cart item count is (\d*)/ do | cart_quantity_count |
  page.find_by_id('cartItemCount').should have_content(cart_quantity_count)
end

Then (/^I should see (\d*) color variants$/) do | color_count |
  all('.question').first.should have_content("renk")
  variant_container = all('.variant-container').first
  variant_container.all('div').count.should eql(color_count.to_i)	
end

And /^I see the default product image$/ do
  @default_image_src = find_by_id('productDetailsCarousel').find('.owl-item.active').find('.product-image')['src']
end

And /^I wait for all Ajax requests to complete/ do
  loop until page.evaluate_script('jQuery.active').zero?
end

When(/^I select the color (.*)/) do | color |
  find("img[alt='#{color}']").click
end

Then /^I see a different image$/ do
  new_image = find_by_id('productDetailsCarousel').find('.owl-item.active').find('.product-image')['src']
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
  page.should have_selector("#notification", visible: :hidden)
end

Then(/^I should see an invalid message notification$/) do
  page.should have_content("Eklemek istediğiniz ürünün adedi geçerli değildir.")
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
  page.find('.recommended-products').all('.owl-item').count.should <= 10
end

And /^I see a picture associated with each product$/ do
  page.find('.recommended-products').all('.owl-item').each do | suggested_product |
    suggested_product.should have_selector('.product-image-wrapper')
  end
end

And /^when I select the first suggested product$/ do
  @product_url = current_url
  page.find('.recommended-products').first('.product-image-wrapper').click
end 

Then /^I see the product details page$/ do
  new_product_url = current_url
  set_wait_time 5
  @product_url.should_not eq(new_product_url)
  revert_to_default_wait_time
end

Then /^I do not see suggestions$/ do
  set_wait_time 5
  expect(page).to_not have_content('.recommended-products')
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
  find_by_id('cartItemCount').should have_content == arg
end

Then(/^I should not be able to add to cart without a variant$/) do
  fill_in "quantity", :with=> 1
  find_by_id("addToCart").click
  page.should have_content("Lütfen bir seçim yapınız.")
  page.should have_selector("#notification", visible: :hidden)
end

And(/^There are "([^"]*)" comments on details$/) do |arg|
  find_by_id('productReviewsTab').click
  div = find_by_id('reviews')
  div.find('li.review-item', match: :first)
  comments = div.all('li.review-item')
  comments.size.should == arg.to_i
end

And(/^I click on more comments button$/) do
  find_by_id('productReviewsTab').click
  find_by_id('showMoreComments').click
  wait_for_ajax
  sleep 2
end

When(/^I click return policy link$/) do
  find_by_id('productReturnPolicy').click
end

Then(/^I get the return policy description$/) do
  find('section.product-detail-container').find_by_id('returnPolicy').should have_content('İncelediğiniz ürünü satın aldıktan sonra beklentilerinizi karşılamadığı takdirde iade edebilirsiniz. İade işlemlerinizi aşağıdaki şekilde yapmalısınız')
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
    visit_link x
    steps %{ Then I don't get the error page }
  }
end

Then(/^I don't see a text indicating that free shipping is available$/) do
  find('.product-featured-details').all('img').select{|x| x['src'].include?('kargo_bedava.png')}.size.should == 0
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
  find('.product-featured-details').should have_no_selector("img[alt='Süper Hızlı Gönderi']")
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

Then(/^Top sellers section should include super fast delivery items$/) do
  find('section.top-seller').should have_content "Süper Hızlı"
end

Then(/^There is a top sellers section$/) do
  sect = find('.top-seller')
  sect.should have_content('Öne Çıkanlar')
  sect.find('div.box.product', match: :first)
  sect.all('div.box.product').size.should <= 9
end

Then(/^I should see deal of the day counter for "([^"]*)"$/) do |arg|
  page.should have_selector(".timer-box.sale-end-timer-days", text: "GÜN")
  page.should have_selector(".timer-box.sale-end-timer-hours", text: "SAAT")
  page.should have_selector(".timer-box.sale-end-timer-minutes", text: "DK")
  page.should have_selector(".timer-box.sale-end-timer-seconds", text: "SN")
  result = execute_sql "select sale_end from dbo.EE_CatalogProducts where sku='#{arg}'"
  t = Time.new
  result.each{|x| t =  x['sale_end']}
  p t
  p Time.now
end


Then(/^I should see stock left for deal of the day items for "([^"]*)"$/) do |arg|
  page.all('.timer-wrapper').select{|x| x['style'] != 'display: none'} .size.should > 0
  page.should have_selector(".timer-box", text: "Ürün")
  item_count = extract_number find(".timer-box", text: "Ürün").text
  result = execute_sql "select StockQty from dbo.Retail_SuperOffer where sku='#{arg}' and Status = 2 ORDER BY ID DESC"
  i = result.first['StockQty'].to_i
  item_count.should == i
end

When(/^I select a variant$/) do |table|
  # table is a table.hashes.keys # => [:renk, :kirmizi-siyah-ekose]
  values = table.raw
  sect = find('div.product-variants-wrapper', visible: true)
  values.each { |x|
    sect.should have_content(/#{x[1]}/i)
    case x[0]
      when 'box'
        div = all('div.variants-wrapper').select{|y| y.first('label', text: /#{x[1]}/i)}[0]
        cls = "v-" + x[2]
        div.find("div.#{cls}").find('label',match: :first).click
        wait_for_ajax
      when 'dd'
        id = "v-" + x[1]
        select_from_dd sect.find_by_id(id) , x[2]
        wait_for_ajax
      when 'radio'
        div = sect.find('.variant-container-with-prices')
        div.find('label', text: x[2]).click
        wait_for_ajax
    end
  }
end

And(/^I increase item count by "([^"]*)"$/) do |arg|
  button = find('.btn-increase')
  i = arg.to_i
  i.times do
    button.click
  end
end

And(/^I decrease item count by "([^"]*)"$/) do |arg|
  button = find('.btn-decrease')
  i = arg.to_i
  i.times do
    button.click
  end
end

And(/^I click reviews tab$/) do
  find_by_id('productReviewsTab').click
  wait_for_ajax
end

Then(/^I see reviews tab$/) do
  name = find_by_id('product-name').text

  i = extract_number find_by_id('productReviewsTab').text
  i.should > 0

  tab = find_by_id('tabProductReviews')
  tab.should have_content name
  tab.should have_selector('img')
  tab.should have_selector('.ratings-table')
  tab.find('.ratings-table').should have_content "Mükemmel"
  tab.find('.ratings-table').should have_content "Çok İyi"
  tab.find('.ratings-table').should have_content "İyi"
  tab.find('.ratings-table').should have_content "Fena Değil"
  tab.find('.ratings-table').should have_content "Çok Kötü"
  tab.should have_content "Ortalama Puan"
  tab.should have_selector('.product-rating')
  tab.should have_selector('.rating-number')

  tab.find('.rating-number').text.to_i.should > 0
  percentages = tab.all('.rating-percentage').collect{|x| extract_number x.text}
  percentages.reduce(:+).should >= 99

  counts = tab.all('.rating-count').collect{|x| extract_number x.text}
  counts.reduce(:+).should == i
end

And(/^I click reviews link on details$/) do
  find('.product-featured-details').find('a.product-comments', text: "Yorumlar").click
  wait_for_ajax
end

And(/^I mark review no "([^"]*)" as "([^"]*)"$/) do |arg1, arg2|
  i = arg1.to_i - 1
  unless i < 0
    reviews = find_by_id('tabProductReviews').all('.review-item')
    case arg2.downcase
      when 'positive'
        reviews[i].find('.answer').find('a', text: "Evet").click
      when 'negative'
        reviews[i].find('.answer').find('a', text: "Hayır").click
    end
    wait_for_ajax
  end
end

Then(/^In comment no "([^"]*)" rating message appears "([^"]*)"$/) do |arg1, arg2|
  i = arg1.to_i - 1
  unless i < 0
    reviews = find_by_id('tabProductReviews').all('.review-item')
    reviews[i].should have_content arg2
  end
end

Then(/^In comment no "([^"]*)" some rating message appears$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    reviews = find_by_id('tabProductReviews').all('.review-item')
    reviews[i].should have_selector('.review-agreed-message')
    reviews[i].find('.review-agreed-message').text.should_not == ""
  end
end

Then(/^There is not a reviews link on details$/) do
  find('.product-featured-details').find_by_id('productReviews').text.should == ""
end

Then(/^I see an empty reviews section$/) do
  name = find_by_id('product-name').text

  i = extract_number find_by_id('productReviewsTab').text
  i.should == 0

  tab = find_by_id('tabProductReviews')
  tab.should have_content name
  tab.should have_selector('img')
  tab.should have_selector('.ratings-table')
  tab.find('.ratings-table').should have_content "Mükemmel"
  tab.find('.ratings-table').should have_content "Çok İyi"
  tab.find('.ratings-table').should have_content "İyi"
  tab.find('.ratings-table').should have_content "Fena Değil"
  tab.find('.ratings-table').should have_content "Çok Kötü"
  tab.should have_content "Ortalama Puan"
  tab.should have_selector('.product-rating')
  tab.should have_selector('.rating-number')

  tab.find('.rating-number').text.to_i.should == 0
  percentages = tab.all('.rating-percentage').collect{|x| extract_number x.text}
  percentages.reduce(:+).should == 0

  counts = tab.all('.rating-count').collect{|x| extract_number x.text}
  counts.reduce(:+).should == 0
end

When(/^I click on first deal of the day$/) do
  find_by_id("dealOfTheDayCarousel").find(".owl-item.active").find("img").click
end

Then(/^I should see deal of the day counter in details$/) do
  button = find_by_id("addToCart")
  sku = button["data-sku"]
  puts "sku: #{sku}"
  page.all('.timer-wrapper').select{|x| x['style'] != 'display: none'} .size.should > 0
  page.should have_selector(".timer-box.sale-end-timer-days", text: "Gün")
  page.should have_selector(".timer-box.sale-end-timer-hours", text: "Saat")
  page.should have_selector(".timer-box.sale-end-timer-minutes", text: "Dk")
  page.should have_selector(".timer-box.sale-end-timer-seconds", text: "Sn")
  days_on_page = find(".timer-box.sale-end-timer-days", text: "Gün").find('div.digits').text.to_i
  hours_on_page= find(".timer-box.sale-end-timer-hours", text: "Saat").find('div.digits').text.to_i
  expect(days_on_page).to be_an(Integer)
  expect(hours_on_page).to be_an(Integer)
  if get_test_data("DEAL_OF_THE_DAY_STRICT")==true
    puts "Strict check for Deal of the Day Time counter"
    result = execute_sql "select SaleEnd from dbo.Retail_SuperOffer where sku='#{sku}'"
    expect(result.count).to eq(1)
    t = Time.new
    result.each{|x| t =  x['SaleEnd']}
    now = Time.now - 10800
    diff = Time.diff(now, t, '%d')
    str = diff[:diff]
    days_from_database = extract_number str
    hours_from_database = diff[:hour]
    expect(days_on_page).to eq(days_from_database)
    expect(hours_on_page).to eq(hours_from_database)
  end

end

Then(/^I should see stock left in details$/) do
  button = find_by_id("addToCart")
  sku = button["data-sku"]
  page.all('.timer-wrapper').select{|x| x['style'] != 'display: none'} .size.should > 0
  page.should have_selector(".timer-box", text: "Ürün")
  item_count = extract_number find(".timer-box", text: "Ürün").text
  expect(item_count.to_i).to be_an(Integer)
  if get_test_data("DEAL_OF_THE_DAY_STRICT")==true
    puts "Strict check for Deal of the Day Time counter"
    result = execute_sql "select StockQty from dbo.Retail_SuperOffer where sku='#{sku}' and Status = 2 ORDER BY ID DESC"
    expect(result.count).to be > 0
    stock_from_database = result.first['StockQty'].to_i
    expect(item_count).to eq(stock_from_database)
  end

end


Then(/^I do not see any compatible products$/) do
  page.should have_no_selector("#compatibleProducts")
  page.should have_no_selector("#compatibleProductTab")
end

When(/^I click on compatible products tab$/) do
  find_by_id("compatibleProducts").click
end

Then(/^I should see compatible products$/) do
  page.should have_selector("#compatibleProductTab")
  page.should have_selector(".table-campatible-products")
  tables = find_by_id('compatibleProductTab').all('.table-campatible-products')
  tables.each { |x|
    rows = x.first('tbody').all('tr')
    rows.each{|y|
      y.find('img')
      y.find('.product-price').text.should_not == ""
      y.find('.add-to-basket.button.small')
    }
  }
end

And(/^There should be only one compatible product group$/) do
  tables = find_by_id('compatibleProductTab').all('.table-campatible-products').size.should == 1
end

And(/^There should be multiple compatible product group$/) do
  tables = find_by_id('compatibleProductTab').all('.table-campatible-products').size.should > 1
end

And(/^I add compatible product no "([^"]*)" to basket$/) do |arg|
  i = arg.to_i - 1
  unless i < 0
    find_by_id('compatibleProductTab').all(".add-to-basket.button.small")[i].click
    # wait_for_ajax
    # page.should have_selector("#notification", :visible => true)
    # page.should have_content("1 Ürün başarılı bir şekilde sepete eklenmiştir.")
    # page.should have_selector("#notification", visible: :hidden)
  end
end

Then(/^All compatible products details should be accessible$/) do
  table = find_by_id('compatibleProductTab').find('tbody', match: :first)
  links = table.all('tr').collect{|x| x.first('a')['href']}
  links.each { |x|
    visit_link x
    steps %{ Then I don't get the error page }
  }
end

Then(/^Totals in topsellers section should not be a link$/) do
  find('.top-seller').find('.title-wrapper').find('p', text: "Toplam")
end

Then(/^There are variants displayed as thumbnails$/) do
  variants = find('.product-variants-wrapper').all('label.thumbnail')
  variants.size.should > 1
  variants.each { |x| x.find('img') }
end

Then(/^The return policy has text type one$/) do
  find_by_id('productReturnPolicy').click
  find_by_id('tabReturnPolicy').should have_content "İncelediğiniz ürünü satın aldıktan sonra beklentilerinizi karşılamadığı takdirde iade edebilirsiniz. İade işlemlerinizi aşağıdaki şekilde yapmalısınız:Ürünün adresinize teslim tarihinden itibaren 14 gün içinde \"Sipariş Takibi\" sayfasından \"İade ve Geri gönderim\" başvurusunda bulunarak iade sürecinizi başlatabilirsiniz. Ürünü iade etmek için, orijinal kutusuyla ve faturasıyla birlikte Hepsiburada.com’a göndermelisiniz. İadenizin kabul edilmesi için, ürünün hasar görmemiş ve kullanılmamış olması gerekmektedir.Daha detaylı bilgi için Yardım sayfasını ziyaret edebilirsiniz.* Bedel İadesi: İade işlemi sonuçlandıktan sonra bedel ödemesi kredi kartınıza/banka hesabınıza 24 saat içinde yapılmaktadır. Ödeme işlemlerinin hesabınıza yansıma süresi bankanıza göre değişkenlik gösterebilir."
  find_by_id('tabReturnPolicy').should have_selector('a', text: "İade başvurusunda nasıl bulunabilirim?")
  find_by_id('tabReturnPolicy').should have_selector('a', text: "Yardım")
end

Then(/^The return policy has text type two$/) do
  find_by_id('productReturnPolicy').click
  find_by_id('tabReturnPolicy').should have_content "İncelediğiniz ürün, Mesafeli Sözleşmelere Dair Yönetmeliğin 7. maddesinde yer alan aşağıdaki hükümler gereğince iade alınmamaktadır.Tüketicinin özel istekleri veya açıkça onun kişisel ihtiyaçları doğrultusunda hazırlanan, niteliği itibariyle geri gönderilmeye elverişli olmayan, çabuk bozulma tehlikesi olan veya son kullanma tarihi geçme ihtimali olan ürünler iade edilemez.Tüketici tarafından ambalajı açılmış ise; ses veya görüntü kayıtlarına, yazılım programlarına ve bilgisayar sarf malzemelerine ilişkin ürünler (Örneğin; DVD, VCD, CD ve kasetler, toner, kartuş, şerit, vb. gibi) iade edilemez.Hijyenik ürünler (iç çamaşırı gibi), süpermarket ürünleri (gıda ürünleri gibi), gazete, dergi gibi süreli yayınlar iade edilemez.Fiyatı borsa veya teşkilatlanmış diğer piyasalarda belirlenen ürünler (altın grubu) iade edilemez.Daha detaylı bilgi için Yardım sayfasını ziyaret edebilirsiniz."
  find_by_id('tabReturnPolicy').should have_selector('a', text: "İade başvurusunda nasıl bulunabilirim?")
  find_by_id('tabReturnPolicy').should have_selector('a', text: "Yardım")
end

Then(/^The return policy has text type three$/) do
  find_by_id('productReturnPolicy').click
  find_by_id('tabReturnPolicy').should have_content "İncelediğiniz ürün, doğrudan üretici firma tarafından size kargoyla gönderilecektir. Bu ürünü satın aldıktan sonra beklentilerinizi karşılamadığı takdirde iade edebilirsiniz. İade işlemlerinizi aşağıdaki şekilde yapmalısınız:Ürünün adresinize teslim tarihinden itibaren 14 gün içinde \"Sipariş Takibi\" sayfasından \"İade ve Geri gönderim\" başvurusunda bulunarak iade sürecinizi başlatabilirsiniz. Başvurunuz sonrasında “Hesabım” sayfasında bulunan başvuru takibi bölümünde gösterilen kargo gönderi kodu ile göndermeniz gerekmektedir. İadenizin kabul edilmesi için, ürünün hasar görmemiş ve kullanılmamış olması gerekmektedir.İade etmek istediğiniz ürün, tarafımızdan üretici firmaya ulaştırılacak ve iade işlemleriniz Hepsiburada.com tarafından takip edilecektir.Daha detaylı bilgi için Yardım sayfasını ziyaret edebilirsiniz. * Bedel İadesi: İade işlemi sonuçlandıktan sonra bedel ödemesi kredi kartınıza/banka hesabınıza 24 saat içinde yapılmaktadır. Ödeme işlemlerinin hesabınıza yansıma süresi bankanıza göre değişkenlik gösterebilir. İade başvurusunda nasıl bulunabilirim?"
  find_by_id('tabReturnPolicy').should have_selector('a', text: "İade başvurusunda nasıl bulunabilirim?")
  find_by_id('tabReturnPolicy').should have_selector('a', text: "Yardım")
end

Then(/^Product details contain "([^"]*)"$/) do |arg|
  find('.timer-wrapper').should have_content arg
end

Then(/^I see delivery time as "([^"]*)"$/) do |arg|
  find('.shipping-time').should have_content arg
end

And(/^I click add comment from product description$/) do
  find(".ratings-container").find("a", text: "Yorum Yap").click
end

Then(/^I should be redirected to login page$/) do
  find_by_id("login-container").find_by_id("email")
  find_by_id("login-container").find_by_id("password")
  find_by_id("login-container").find("button", text: "Giriş")
end

And(/^I click add comment from comments tab$/) do
  find_by_id("productReviewsTab").click
  expect(page).to have_selector('#tabProductReviews')
  reviews_box = find_by_id("reviewContainer")
  reviews_box.find("a", text: "Puan ver Yorum yap").click
end

Then(/^Comment fields should appear as expected$/) do
  div = find_by_id("addReviewContainer")
  title = div.find('h5')
  title.text.should == find_by_id("product-name").text
  div.find('label', text: "Yorumunuza bir başlık yazınız.")
  div.find('label', text: "Ürünle ilgili düşüncelerinizi buraya yazınız.")
  div.find('label', text: "Puan Ver")
  div.should have_content "Yorumda İsmim gözüksün"
  header = div.find_by_id('txtTitle')
  review = div.find_by_id('txtReview')
  header_counter = div.all("span.count").select{|x| x["data-bind"] == "text: titleCount()"}.first
  review_counter = div.all("span.count").select{|x| x["data-bind"] == "text: reviewCount()"}.first
  header_counter.text.should == "150"
  review_counter.text.should == "2000"
  div.find_by_id('rating-1')
  div.find_by_id('rating-2')
  div.find_by_id('rating-3')
  div.find_by_id('rating-4')
  div.find_by_id('rating-5')
  div.find('label', text: "Evet")
  div.find('label', text: "Hayır")
  button = div.find('a', text: 'Yorum Yap')
end

Then(/^I should not be able to submit without mandatory fields$/) do
  div = find_by_id("addReviewContainer")
  button = div.find('a', text: 'Yorum Yap')
  button.click
  div.find_by_id("messageContainer", text: "Lütfen başlık giriniz.")
  div.find_by_id("messageContainer", text: "Lütfen yorum giriniz.")
  div.find_by_id("messageContainer", text: "Lütfen puan seçiniz.")
  header = div.find_by_id('txtTitle')
  review = div.find_by_id('txtReview')
  header.set "Comment header test1"
  review.set "Comment review should be at least five sentences test1"
  button.click
  div.find_by_id("messageContainer", text: "Lütfen puan seçiniz.")

  header.set ""
  review.set "Comment review should be at least five sentences test2"
  div.find_by_id('rating-3').click
  button.click
  div.find_by_id("messageContainer", text: "Lütfen başlık giriniz.")

  header.set "Comment header test2"
  review.set ""
  div.find_by_id('rating-2').click
  button.click
  div.find_by_id("messageContainer", text: "Lütfen yorum giriniz.")

  header.set "as"
  review.set "new rev"
  button.click
  div.find_by_id("messageContainer", text: "Lütfen daha açıklayıcı başlık giriniz.")
  div.find_by_id("messageContainer", text: "Lütfen daha açıklayıcı yorum giriniz.")
  end

Then(/^I should not be able to pass character limits$/) do
  div = find_by_id("addReviewContainer")
  header = div.find_by_id('txtTitle')
  review = div.find_by_id('txtReview')
  c_150 = "Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0"
  c_151 = "Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl01"
  c_2000 = "Asdfghjkl0Asdfghjkl0Asdfghj l0Asdfghjkl0Asdfghjkl0Asdfghjkl0A dfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asd ghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjk 0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdf hjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfgh kl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0"
  c_2002 = "Asdfghjkl0Asdfghjkl0Asdfghj l0Asdfghjkl0Asdfghjkl0Asdfghjkl0A dfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asd ghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjk 0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdf hjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfgh kl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl0Asdfghjkl023"
  c_special = "# ? .. : < > >|||| !'^+%&/() ^'&/()=)(){[$½#$½£$#[#½\" "
  header_counter = div.all("span.count").select{|x| x["data-bind"] == "text: titleCount()"}.first
  header.set c_151
  header.value.should_not == c_151
  header.value.should == c_150
  header_counter.text.should == "0"
  header.set c_150
  header.value.should == c_150
  header_counter.text.should == "0"

  review_counter = div.all("span.count").select{|x| x["data-bind"] == "text: reviewCount()"}.first
  review.set c_2002
  review.value.should_not == c_2002
  review.value.should == c_2000
  review_counter.text.should == "0"
  review.set c_2000
  review.value.should == c_2000
  review_counter.text.should == "0"
  
  header.set "ab"
  header_counter.text.should == "148"
  header.set "alper"
  header_counter.text.should == "145"
  header.set "alper gamze"
  header_counter.text.should == "139"

  review.set "as"
  review_counter.text.should == "1998"
  review.set "alper"
  review_counter.text.should == "1995"
  review.set "alper gamze"
  review_counter.text.should == "1989"
end

Then(/^I add a comment with these values$/) do |table|
  values = Hash[table.raw]
  $comments_used_in_test[$num_comments_used_in_test] = {'header' => values['header'], 'review' => values['review'], 'rating' => values['rating'], 'show_name' => values['show_name'], 'sku' => values['sku']}
  $num_comments_used_in_test+=1
  # table is a table.hashes.keys # => [:header, :başlık]
  div = find_by_id("addReviewContainer")
  button = div.find('a', text: 'Yorum Yap')
  header = div.find_by_id('txtTitle')
  review = div.find_by_id('txtReview')
  header.set values['header']
  review.set values['review']
  i = extract_number values['rating']
  div.find_by_id("rating-#{i.to_s}").click
  shw_name = values['show_name']
  div.find('label', text: shw_name).click
  button.click
end

And(/^I delete comment from db$/) do |table|
  # table is a table.hashes.keys # => [:header, :başlık]
  values = Hash[table.raw]
  execute_sql %"delete top(1) from i_yorum where
                yorumheader='#{values['header']}' and yorum = '#{values['review']}'
                and pf_id = '#{values['sku'].downcase}'"
end

And(/^I get a message about successful comment adding$/) do
  title = find_by_id('product-name').text
  message = find_by_id('successReviewMessage')
  message.should have_content title
  message.should have_content "Bu ürün hakkındaki deneyimlerinizi paylaştığınız için teşekkür ederiz. Yorumunuz uygun bulunduğu takdirde en geç bir hafta içinde yayınlanacaktır. Unutmayınız ki yorumların amacı kullanıcılara en doğru bilgiyi direkt olarak bu ürünü kullanan tarafından ulaştırılmasını sağlamaktır. Firmaları ya da kişileri doğrudan hedef alan taraflı yazılar yayınlanmayabilir."
  message.find('a.closebtn').click
end

And(/^Admin approves added comment$/) do |table|
  # table is a table.hashes.keys # => [:header, :başlık]
  values = Hash[table.raw]
  execute_sql %"update top(1) i_yorum set onay = 1
                where yorumheader = '#{values['header']}' and yorum = '#{values['review']}'
                and pf_id = '#{values['sku'].downcase}'"
end

And(/^I see the approved comment on the product detail$/) do |table|
  # table is a table.hashes.keys # => [:header, :başlık]
  values = Hash[table.raw]
  steps %{And I refresh page}
  steps %{And I click add comment from comments tab}
  review = find_by_id('reviews').find('li.review-item', match: :first)
  rating = extract_number values['rating']
  review.should have_content values['header']
  review.should have_content values['review']
  review.should have_content values['name']
  review.should have_selector("div[style='width: #{(rating*20).to_s}%']")
  date = Time.now.strftime("%2d.%2m.%4Y")
  review.find('strong.date').should have_content date
end

And(/^I get an error message while adding comment "([^"]*)"$/) do |arg|
  find_by_id('messageContainer').should have_content arg
end

And(/^Admin rejects comment for header "([^"]*)" and review "([^"]*)" and "([^"]*)"$/) do |arg1, arg2, arg3|
  header = arg1
  review = arg2
  sku = arg3
  execute_sql "update top(1) i_yorum set onay = 2 where yorumheader='#{header}' and yorum = '#{review}' and pf_id = '#{sku.downcase}' and onay = -1"
end


And(/^We change date on rejected comment "([^"]*)" "([^"]*)" "([^"]*)"$/) do |arg1, arg2, arg3|
  header = arg1
  review = arg2
  sku = arg3
  execute_sql "update top(1) i_yorum set date = '2015-01-01 10:26:34.110' where yorumheader='#{header}' and yorum = '#{review}' and pf_id = '#{sku.downcase}' and onay = 2"
end

Then(/^I should see badges with these images$/) do |table|
  # table is a table.hashes.keys # => [:hb_90x50_1.png]
  values = table.raw
  values.each{ |x|
    find('.badge-boxes').all('img').select{|y| y['src'].include? x[0] }.size.should == 1
  }
end

Then(/^I should see badges for the product "([^"]*)"$/) do |arg|
  response = RestClient.get "http://productinformation.qa.hepsiburada.com/product/sku/#{arg}?expand=campaignbadges"
  resp = JSON.parse response
  badges = resp['campaignBadges'].collect{|x| x['badge']}
  img_sources = find('.badge-boxes').all('.ProductDashboard_button').collect{|x| x.first('img')['src']}
  img_sources.map!{|x| x.split("/").last }
  img_sources.each { |x|
    badges.grep(/#{x}/).size.should == 1
  }
end