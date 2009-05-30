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

Given /^a user exists in the system with the email "([^\"]*)"$/ do |email|
  Given 'no users exist in the system'
  When 'I visit "/register"'
  When 'I enter valid registration information'
  When 'I enter "' + email + '" for "user_email"'
  When 'I click the "user_submit" button'
end

When /^I enter valid registration information$/ do
  When 'I enter "user@host.com" for "user_email"'
  When 'I enter "password" for "user_password"'
  When 'I enter "password" for "user_password_confirmation"'
  When 'I check the "user_terms" box'
end