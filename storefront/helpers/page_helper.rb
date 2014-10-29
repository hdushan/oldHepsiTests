def wait_for_visibility(page, selector, visible)
  @javascript
  page.should have_selector(selector, visible: visible)
end

def all_satisfy(expected)
  RSpec::Matchers::BuiltIn::All.new(expected)
end

def prices_to_list(items)
  list = []
  items.each do |item|
    list << price_from_string(item.find('.product-price').text)
  end
  list
end

def price_from_string(string)
  string.gsub!(/,/, '.')
  string.gsub!(/[^0-9 .]/, '').to_f
end