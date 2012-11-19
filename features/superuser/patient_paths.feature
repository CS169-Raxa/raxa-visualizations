Feature: time of patient paths

  As a superuser
  I want to see the time between each event of a patient's path through the hospital
  so that I can easily identify hangups

  Background: patients exist
    Given Patients A-B exist
    And Patient B has the following events:
      | type  | department   | timestamp      |
      | start | registration | 60 minutes ago |
      | end   | registration | 54 minutes ago |
      | start | wait         | 54 minutes ago |
      | end   | wait         | 40 minutes ago |
      | start | screening    | 40 minutes ago |
      | end   | screening    | 36 minutes ago |
      | start | wait         | 36 minutes ago |
      | end   | wait         | 15 minutes ago |
      | start | inpatient    | 15 minutes ago |

  Scenario: patients with no history display an error message
    When I look at the timeline for Patient A
    Then I should see "No history available."

  Scenario: display timeline for patients with history
    When I look at the timeline for Patient B
    Then first I should see a registration block for 6 minutes
    And then I should see a wait block for 14 minutes
    And then I should see a screening block for 4 minutes
    And then I should see a wait block for 21 minutes
    And last I should see an inpatient block for 15 minutes
