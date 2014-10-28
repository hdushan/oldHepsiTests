def wait_for_visibility(page, selector, visible)
  @javascript
  expect(page.should have_selector(selector, visible: visible))
end