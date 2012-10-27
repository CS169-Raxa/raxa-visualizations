Feature: show total number of patients registered today on registration dashboard

  As a registration worker,
  I want to see the number of patients I have registered today,
  So that I can keep track of my progress for today

  Background: registrations have occurred
    Given that 5 patients have been registered today
    And I am on the registration dashboard

  Scenario: show number on registration dashboard
    Then I should see that 5 patients were registered today

  Scenario: update number shown after information about a completed registration is received
    When I register a patient
    Then I should see that 6 patients were registered today

  Scenario: reset number to zero at the end of the day
    When it is the next day
    Then I should see that 0 patients were registered today