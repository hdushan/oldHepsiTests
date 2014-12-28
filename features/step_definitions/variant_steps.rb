#encoding: UTF-8
Then(/^There are "([^"]*)" select box variant groups$/) do |arg|
  i = arg.to_i
  find('.variant-container', match: :first)
  variants = all('.variant-container')
  variants.size.should == i
  variants.each { |x|
    x.all('div').select{|y| y['class'] != ""}.select{ |y| y['class'].include?('radio-variant') == false }.size.should == 0
  }
  labels = find('.product-variants-wrapper').all('label.question')
  labels.size.should >= i
  labels.each { |x| x.text.should_not == "" }
end

Then(/^There are "([^"]*)" radio button variant groups$/) do |arg|
  i = arg.to_i
  find('.variant-container-with-prices', match: :first)
  variants = all('.variant-container-with-prices')
  variants.size.should == i
  variants.each { |x|
    x.all('label').select{|y| y['class'] != ""}.select{ |x| x['class'].include?('price-label') == false }.size.should == 0
  }
  labels = find('.product-variants-wrapper').all('label.question')
  labels.size.should >= i
  labels.each { |x| x.text.should_not == "" }
end

Then(/^There are "([^"]*)" dropdown variant groups$/) do |arg|
  i = arg.to_i
  find('.select-styled', match: :first)
  variants = all('.select-styled')
  variants.size.should == i
  variants.each { |x|
    x.find('select').all('option').size.should > 1
    x.find('select').all('option').select{|x| x.selected? }[0].text.should == "Seçiniz"
  }
  labels = find('.product-variants-wrapper').all('label.question')
  labels.size.should >= i
  labels.each { |x| x.text.should_not == "" }
end

And(/^I should be able to cycle through variants$/) do
  variants_container = find('.product-variants-wrapper')
  select_boxes = variants_container.all('div.variant-container')
  radio_buttons = variants_container.all('div.variant-container-with-prices')
  dropdowns = variants_container.all('div.select-styled')
  
  select_boxes.each { |x|
    x.all('label').each { |y|
      y.click
      wait_for_ajax
    }
  }
  radio_buttons.each { |x|
    x.all('label').each { |y|
      y.click
      wait_for_ajax
    }
  }
  dropdowns.each { |x|
    dd = x.find('select')
    options = dd.all('option')
    options.each { |y| y.select_option }
    wait_for_ajax
  }
end

And(/^I should be able to cycle through variants having unprocurables exposed$/) do
  variants_container = find('.product-variants-wrapper')
  select_boxes = variants_container.all('div.variant-container')
  radio_buttons = variants_container.all('div.variant-container-with-prices')
  dropdowns = variants_container.all('div.select-styled')

  unprocurable_found = false
  select_boxes.each { |x|
    x.all('label').each { |y|
      y.click
      wait_for_ajax
      if variants_container.all('.not-available').size > 0
        unprocurable_found = true
      end
    }
  }
  radio_buttons.each { |x|
    x.all('label').each { |y|
      y.click
      wait_for_ajax
      if variants_container.all('.not-available').size > 0
        unprocurable_found = true
      end
      if find('.procurable-status-wrapper').text == "Bu ürün geçici olarak temin edilememektedir."
        unprocurable_found = true
      end
    }
  }
  dropdowns.each { |x|
    dd = x.find('select')
    options = dd.all('option')
    options.each { |y| y.select_option }
    wait_for_ajax
    if variants_container.all('.not-available').size > 0
      unprocurable_found = true
    end
  }
  unprocurable_found.should == true
end