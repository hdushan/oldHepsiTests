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

def clean_string str
  str.gsub(/[0-9\(\)]/, '').strip
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
    begin
      loop until page.evaluate_script('jQuery.active').zero?
    rescue Exception => e
      sleep 1
    end
  end
end

def calculate_discount
  i = format_price find('section.detail-main').find("span.price").text
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
    price_from_string(item.find('span.price').text)
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

def array_has_item_without arr
  self.each { |x|
    arr.each { |y|

    }
  }
end

def get_file_name str
  return str.split("/").last
end

def visit_main_page
  begin
    visit ''
  rescue Timeout::Error
    visit ''
  end
end

def execute_sql str
  mssql = TinyTds::Client.new(
      :dataserver => 'euclide2.hepsiburada.dmz',
      :port => '1433',
      :username => 'DMARKET\amermer',
      :password => 'Aa12345_7',
      :database => 'HBDB_TEST'
  )
  results = mssql.execute(str)
  return results
end

def select_from_dd dd, option
  dd.find('option', text: option).select_option
end

def visit_link link
  if link == ""
    visit_main_page
  else
    begin
      visit format_link(link)
    rescue Timeout::Error
      visit format_link(link)
    rescue Timeout::Error
      p "Timeout on page: #{link}"
    end
  end
end

def clear_special str
  return str.gsub(/[^0-9A-Za-z]/, '')
end

def capitalize str
  new = String.new
  for i in 0..(str.size - 1)
    case str[i]
      when 'i'
        new << 'İ'
      when 'ç'
        new << 'Ç'
      when 'ü'
        new << 'Ü'
      when 'ğ'
        new << 'Ğ'
      when 'ı'
        new << 'I'
      when 'ş'
        new << 'Ş'
      when 'ö'
        new << 'Ö'
      else
        new << str[i].upcase
    end
  end
  return new.to_s
end

def lower_case str
  new = String.new
  for i in 0..(str.size - 1)
    case str[i]
      when 'İ'
        new << 'i'
      when 'Ç'
        new << 'ç'
      when 'Ş'
        new << 'ş'
      when 'Ü'
        new << 'ü'
      when 'Ğ'
        new << 'ğ'
      when 'I'
        new << 'ı'
      when 'Ö'
        new << 'ö'
      else
        new << str[i].downcase
    end
  end
  return new.to_s
end

Capybara::Node::Element.class_eval do
  def click_at(x, y)

      right = x - (native.size.width / 2)
      top = y - (native.size.height / 2)
      driver.browser.action.move_to(native).move_by(right.to_i, top.to_i).click.perform

  end
end