#encoding: UTF-8
Before ('@merchant_disabled') do
  visit '/protected/feature'
  check = find_by_id "MarketplaceFeaturedOnProductPage"
  if check['checked']
    find('label', :text=> 'MarketplaceFeaturedOnProductPage').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

Before ('@merchant_enabled') do
  visit '/protected/feature'
  check = find_by_id "MarketplaceFeaturedOnProductPage"
  unless check['checked']
    find('label', :text=> 'MarketplaceFeaturedOnProductPage').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

Before ('@discounts_and_topsellers_disabled') do
  disable_discounts_and_topsellers
end

Before ('@mobile_discounts_and_topsellers_disabled') do
  visit '/m/protected/feature'
  check = find_by_id "TopSellersOnCategoryPageFeature"
  if check['checked']
    find('label', :text=> 'TopSellersOnCategoryPageFeature').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

Before ('@discounts_and_topsellers_enabled') do
  visit '/protected/feature'
  check = find_by_id "TopSellersOnCategoryPageFeature"
  unless check['checked']
    find('label', :text=> 'TopSellersOnCategoryPageFeature').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

def disable_discounts_and_topsellers
  visit '/protected/feature'
  check = find_by_id "TopSellersOnCategoryPageFeature"
  if check['checked']
    find('label', :text=> 'TopSellersOnCategoryPageFeature').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

After ('@discounts_and_topsellers_enabled') do
  disable_discounts_and_topsellers
end


Before ('@recommended_products_on_product_detail_page_enabled') do
  visit '/protected/feature'
  check = find_by_id "RecommendedProductsFeaturedOnProductPage"
  unless check['checked']
    find('label', :text=> 'RecommendedProductsFeaturedOnProductPage').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

Before ('@recommended_products_on_product_detail_page_disabled') do
  visit '/protected/feature'
  check = find_by_id "RecommendedProductsFeaturedOnProductPage"
  if check['checked']
    find('label', :text=> 'RecommendedProductsFeaturedOnProductPage').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

Before '@chrome' do
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.current_driver  = :chrome
  Capybara.default_driver = :chrome
  Capybara.javascript_driver = :chrome
  Capybara.page.driver.browser.manage.window.maximize
end

Before '~@chrome' do
  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end

  Capybara.current_driver  = :firefox
  Capybara.default_driver = :firefox
  Capybara.javascript_driver = :firefox
  Capybara.page.driver.browser.manage.window.maximize
end