#encoding: UTF-8
Before ('@merchant_disabled') do
  if $merc_enabled != 0
    visit '/protected/feature'
    check = find_by_id "MarketplaceFeaturedOnProductPage"
    if check['checked']
      find('label', :text=> 'MarketplaceFeaturedOnProductPage').click
      find('button', :text=> "Save").click
      sleep 1.5
    end
    $merc_enabled = 0
  end
end

Before ('@mobile_merchant_disabled') do
  visit '/m/protected/feature'
  check = find_by_id "MarketplaceFeaturedOnProductPage"
  if check['checked']
    find('label', :text=> 'MarketplaceFeaturedOnProductPage').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

Before ('@merchant_enabled') do
  if $merc_enabled != 1
    visit '/protected/feature'
    check = find_by_id "MarketplaceFeaturedOnProductPage"
    unless check['checked']
      find('label', :text=> 'MarketplaceFeaturedOnProductPage').click
      find('button', :text=> "Save").click
      sleep 1.5
    end
    $merc_enabled = 1
  end
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

Before ('@mobile_compatibles_enabled') do
  visit '/m/protected/feature'
  check = find_by_id "CompatibleProducts"
  unless check['checked']
    find('label', :text=> 'CompatibleProducts').click
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
  begin
    Capybara.page.driver.browser.manage.window.maximize
  rescue Exception => e
    p "Unable to maximize window!!!"
  end
end

Before '~@chrome' do
  Capybara.current_driver  = :firefox
  Capybara.default_driver = :firefox
  Capybara.javascript_driver = :firefox
  begin
    Capybara.page.driver.browser.manage.window.maximize
  rescue Exception => e
    p "Unable to maximize window!!!"
  end
end

After  do |scenario|
  if scenario.failed?
    page.save_screenshot(Capybara.save_and_open_page_path + "/#{scenario.name}-#{$screenshot_counter.to_s}-failed.png")
    $screenshot_counter += 1
  end
end

After('@warmup') do |scenario|
  begin
    p scenario.name
  rescue
    p "Something went wrong in warmup"
  end
end

Before('@login_enabled') do
  visit '/protected/feature'
  check = find_by_id "LoginLogout"
  unless check['checked']
    find('label', :text=> 'LoginLogout').click
    find('button', :text=> "Save").click
    sleep 1.5
  end
end

# scenario_times = {}
#
# Around() do |scenario, block|
#   start = Time.now
#   block.call
#   scenario_times["#{scenario.feature.file}::#{scenario.name}"] = Time.now - start
# end
#
# at_exit do
#   max_scenarios = scenario_times.size > 20 ? 20 : scenario_times.size
#   puts "------------- Top #{max_scenarios} slowest scenarios -------------"
#   sorted_times = scenario_times.sort { |a, b| b[1] <=> a[1] }
#   sorted_times[0..max_scenarios - 1].each do |key, value|
#     puts "#{value.round(2)}  #{key}"
#   end
# end
