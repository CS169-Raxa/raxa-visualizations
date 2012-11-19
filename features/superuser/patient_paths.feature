Feature: time of patient paths

  As a superuser
  I want to see the time between each event of a patient's path through the hospital
  so that I can easily identify hangups

  Background: patients exist
    Given Patients A-B exist
    And Patient B has the following encounters:
      | department   | start_time     | end_time       |
      | registration | 60 minutes ago | 54 minutes ago |
      | wait         | 54 minutes ago | 40 minutes ago | 
      | screening    | 40 minutes ago | 36 minutes ago |
      | wait         | 36 minutes ago | 15 minutes ago |
      | inpatient    | 15 minutes ago |                |

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
