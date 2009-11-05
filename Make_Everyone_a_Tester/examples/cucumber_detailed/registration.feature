# registration.feature

Feature: User Registration
  In order to identify users in the system
  Users must be able to log in

  Scenario: Successful registration
    Given no users exist in the system
    When I visit "/register"
    And I enter "user@host.com" for "user_email"
    And I enter "password" for "user_password"
    And I enter "password" for "user_password_confirmation"
    And I check the "user_terms" box
    And I click the "user_submit" button
    Then I should be redirected to "/"
    And I should see the message "Welcome to Spasibo. A winner is you!"
  
  Scenario: Successful registration with alternate data
    Given no users exist in the system
    When I visit "/register"
    And I enter "patrick@viget.com" for "user_email"
    And I enter "password123" for "user_password"
    And I enter "password123" for "user_password_confirmation"
    And I check the "user_terms" box
    And I click the "user_submit" button
    Then I should be redirected to "/"
    And I should see the message "Welcome to Spasibo. A winner is you!"
    
  Scenario: No data supplied
    Given no users exist in the system
    When I visit "/register"
    And I click the "user_submit" button
    Then I should be redirected to "/register"
    And I should see the message "NYET! A FAIL IS YOU"
    And I should see the message "Email can't be blank"
    And I should see the message "Terms must be accepted"
    
  Scenario: Password not confirmed
    Given no users exist in the system
    When I visit "/register"
    And I enter "user@host.com" for "user_email"
    And I enter "password" for "user_password"
    And I enter "drowssap" for "user_password_confirmation"
    And I check the "user_terms" box
    And I click the "user_submit" button
    Then I should be redirected to "/register"
    And I should see the message "NYET! A FAIL IS YOU"
    And I should see the message "Password doesn't match confirmation"

  @slow
  Scenario: Duplicate email address
    Given a user exists in the system with the email "user@host.com"
    When I visit "/register"
    And I enter valid registration information
    And I enter "user@host.com" for "user_email"
    And I click the "user_submit" button
    Then I should be redirected to "/register"
    And I should see the message "Email has already been taken"
