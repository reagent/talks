Given /^no users exist in the system$/ do
  open "#{BASE_URL}/setup/clean_slate"
end

When /^I visit "([^\"]*)"$/ do |path|
  @browser.open path
end

When /^I enter "([^\"]*)" for "([^\"]*)"$/ do |value, text_field_id|
  @browser.type text_field_id, value
end

When /^I check the "([^\"]*)" box$/ do |checkbox_id|
  @browser.check checkbox_id
end

When /^I click the "([^\"]*)" button$/ do |submit_button_id|
  @browser.click submit_button_id
  @browser.wait_for_page_to_load
end

Then /^I should be redirected to "([^\"]*)"$/ do |path|
  assert_equal "#{BASE_URL}#{path}", @browser.get_location
end

Then /^I should see the message "([^\"]*)"$/ do |message|
  assert @browser.is_text_present(message)
end