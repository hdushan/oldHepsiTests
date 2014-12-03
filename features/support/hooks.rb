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
  visit '/protected/feature'
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
