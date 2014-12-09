#encoding: UTF-8
def set_wait_time seconds
  Capybara.default_wait_time = seconds.to_i
end

def revert_to_default_wait_time
  Capybara.default_wait_time = $default_wait_time
end

def extract_number str
  str.gsub(/[^0-9]/, '').to_i
end

def get_result_count
  extract_number(find_by_id('totalItems').text)
end

def format_price str
  str.gsub!(/[.A-z ]/, "")
  str.gsub!(',', '.')
  return str.to_f
end

def wait_for_ajax
  Timeout.timeout(Capybara.default_wait_time) do
    loop until page.evaluate_script('jQuery.active').zero?
  end
end

def calculate_discount
  i = format_price find_by_id("offering-price").text
  k = format_price find_by_id('originalPrice').text
  diff = k - i
  return ((diff/k)*100.0).round
end

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

def delete_last_word str
  return str[0...str.rindex(' ')]
end

def format_link str
  uri = URI.parse(URI.encode(str.strip))
  return uri
end