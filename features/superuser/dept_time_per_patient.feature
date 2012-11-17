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
      | registration | 1 day, 60 minutes ago | 1 day, 52 minutes ago |
      | registration | 30 minutes ago        | 20 minutes ago        |

    Given I am on the superuser dashboard

  Scenario: display graph for registration
    When I click on the "Registration" stage
    Then I should see an average time of 8 minutes per patient
    And I should see a graph
    And there should be 2 data items on the graph with averages: 6,9

  Scenario: display no history notification
    When I click on the "Screener" stage
    Then I should see a "-" for average time per patient
    And I should not see a graph
    And I should see "No screener history available"
