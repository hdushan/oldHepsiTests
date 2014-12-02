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
  i = format_price find_by_id("offering-price").first('span').text
  k = format_price find_by_id('originalPrice').text
  p i
  p k
  p (i/k)
  return (100 - ((i/k)*100).to_i).to_i
end