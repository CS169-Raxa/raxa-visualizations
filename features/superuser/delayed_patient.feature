Feature: alerts for patients experiencing abnormal delays

  As a superuser
  I want to see if a patient is being delayed individually
  so that I can intervene and follow up

  Background: patients exist
    Given Patients A-B exist
    And the average wait time is 20 minutes
    And the average registration time is 10 minutes
    And Patient A has been in wait for 20 minutes
    And Patient B has been in registration for 20 minutes
    And I am on the superuser dashboard

  Scenario: patients that have not been delayed abnormally should not trigger alerts
    Then I should not see an abnormal delay alert for Patient A

  Scenario: patients waiting for twice the average time should trigger alerts
    Then I should see an abnormal delay alert for Patient B

  Scenario: patients triggering alerts should be displayed first
    Then I should list "Patient B" before "Patient A"
