def wait_for_visibility(page, selector, visible)
  @javascript
  page.should have_selector(selector, visible: visible)
end

def all_satisfy(expected)
  RSpec::Matchers::BuiltIn::All.new(expected)
end

def prices_to_list(items)
  items.map { |item|
    price_from_string(item.find('.product-price').text)
  }
end

def price_from_string(string)
  string.gsub!(/[^0-9 ,]/, '')
  string.gsub!(/,/, '.').to_f
end