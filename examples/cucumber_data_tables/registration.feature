# registration.feature

Feature: User Registration
  In order to identify users in the system
  Users must be able to log in

  Scenario Outline: Successful registration
    Given no users exist in the system
    When I visit "/register"
    And I enter "<email>" for "user_email"
    And I enter "<password>" for "user_password"
    And I enter "<password_confirmation>" for "user_password_confirmation"
    And I check the "user_terms" box
    And I click the "user_submit" button
    Then I should be redirected to "/"
    And I should see the message "Welcome to Spasibo. A winner is you!"
    
    Examples:
      | email             | password    | password_confirmation |
      | user@host.com     | password    | password              |
      | patrick@viget.com | password123 | password123           |
