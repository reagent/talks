# registration.feature

Feature: User Registration
  In order to identify users in the system
  Users must be able to log in

  Scenario: Successful Registration
    Given no users exist in the system
    When I visit the registration page
    And I enter valid registration information
    And I submit the form
    Then I should be redirected to the home page
    And I should see a success message displayed