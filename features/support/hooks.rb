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

After('@warmup') do |scenario|
  begin
    p scenario.name
  rescue Exception => e
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

Before('@firefox') do
  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end
  Capybara.default_driver = :firefox
  Capybara.current_driver = :firefox
  Capybara.javascript_driver = :firefox
  begin
    Capybara.current_session.driver.browser.manage.window.resize_to(1920, 1080)
    #Capybara.page.driver.browser.manage.window.maximize
  rescue Exception => e
    p "Unable to maximise window!!!"
    p e.to_s
  end
end

After('@firefox') do
  Capybara.default_driver = :selenium
  Capybara.current_driver = :selenium
  Capybara.javascript_driver = :selenium
end

Before('@journey') do
  set_wait_time 60
end

After('@journey') do
  revert_to_default_wait_time
end

Before('@blah2') do
  puts "Before blah2"
end

Before('@blah1') do
  puts "Before blah1"
end

After('@blah2') do
  puts "After blah2"
end

After('@blah1') do
  puts "After blah1"
end

After('@logout_after_test') do
  visit_main_page
  div = find_by_id('myAccount')
  div.hover
  begin
    puts "\n\nLogging out in hook"
    find('a', text: "Çıkış Yap").click
    puts "\n\nLogging out in hook: Successful"
  rescue Exception => e
    puts e
    puts "\n\nLogging out in hook: UnSuccessful"
  end
  sleep 2
end

Before('@add_comments_test') do
  puts "Resetting list of comments to null"
  $comments_used_in_test = {}
  $num_comments_used_in_test = 0
end

After('@add_comments_test') do
  puts "Cleaning up comments"
  $comments_used_in_test.each do |k, v|
    puts "Deleting comment: #{v.inspect}"
    execute_sql %"delete top(1) from i_yorum where
                yorumheader='#{v['header']}' and yorum = '#{v['review']}'
                and pf_id = '#{v['sku'].downcase}'"
  end
end


After('@clear_data_and_close_browser_after_test') do
  Capybara.reset_sessions!
  $result_stack.clear
  puts "\n Cleared data after test in hook"
  page.execute_script "window.close();"
end

After  do |scenario|
  if scenario.failed?
    page.save_screenshot(Capybara.save_and_open_page_path + "/#{clear_special scenario.name}-#{$screenshot_counter.to_s}-failed.png", :full => true)
    $screenshot_counter += 1
  end
end

# Around do |scenario, block|
#   p "first"
#   block.call
#   p "third"
# end

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
