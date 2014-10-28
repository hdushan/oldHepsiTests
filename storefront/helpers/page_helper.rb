def wait_for_visibility(page, selector, visible)
  @javascript
  page.should have_selector(selector, visible: visible)
end

def all_satisfy(expected)
  RSpec::Matchers::BuiltIn::All.new(expected)
end
