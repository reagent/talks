Given /^no users exist in the system$/ do
  open "#{BASE_URL}/setup/clean_slate"
end

When /^I visit the registration page$/ do
  @browser.open '/register'
end

When /^I enter valid registration information$/ do
  @browser.type  "user_email", "user@host.com"
  @browser.type  "user_password", "password"
  @browser.type  "user_password_confirmation", "password"
  @browser.click "user_terms"
end

When /^I submit the form$/ do
  @browser.click "user_submit"
  @browser.wait_for_page_to_load
end

Then /^I should be redirected to the home page$/ do
  assert_equal "#{BASE_URL}/", @browser.get_location
end

Then /^I should see a success message displayed$/ do
  assert @browser.is_text_present('Welcome to Spasibo. A winner is you!')
end