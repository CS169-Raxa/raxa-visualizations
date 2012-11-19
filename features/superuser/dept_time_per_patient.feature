Feature: loads on each department

  As a superuser
  I want to see a graph of each department's load throughout the day
  so that I can evaluate the department's performance over time.

  https://www.pivotaltracker.com/story/show/37729715

  Background:

    Given Patients A-B exist
    And Patient A has the following encounters:
      | department   | start_time     | end_time       |
      | registration | 60 minutes ago | 54 minutes ago |
    And Patient B has the following encounters:
      | department   | start_time            | end_time              |
      | registration | 3660 minutes ago      | 3652 minutes ago      |
      | registration | 30 minutes ago        | 20 minutes ago        |
    And the screener department exists

    Given I am on the superuser dashboard

  Scenario: display graph for registration
    When I click on the "registration" stage
    Then I should see an average time of 8 minutes per patient
    And I should see a graph

  Scenario: display no history notification
    When I click on the "screener" stage
    Then I should see a "-" for average time per patient
    And I should not see a graph
    And I should see "No screener history available"
