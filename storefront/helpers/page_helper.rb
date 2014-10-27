def wait_for_visibility(page, selector, visible)
  @javascript
  page.should have_selector(selector, visible: visible)
end