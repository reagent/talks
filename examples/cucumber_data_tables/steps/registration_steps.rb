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

When /^I enter valid registration data$/ do
  @browser.type  "user_email", "user@host.com"
  @browser.type  "user_password", "password"
  @browser.type  "user_password_confirmation", "password"
  @browser.click "user_terms"
end

Given /^a user exists in the system with the email "([^\"]*)"$/ do |email|
  Given "no users exist in the system"
  And "I visit \"/register\""
  And "I enter valid registration data"
  And "I enter \"#{email}\" for \"user_email\""
  And "I click the \"user_submit\" button"
end