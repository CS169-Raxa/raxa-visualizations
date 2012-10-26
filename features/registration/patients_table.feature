Feature: See a table of the patients I have registered

  As a registration worker
  I want to see a table of all patients registered (with their status of new/returning and time registered) listed by how recently they were registered,
  So that I can keep track of what patients I have registered today and in previous days.

Background: Some patients have been registered 
    Given the following patients exist:
      | id | name      | 
      | 1  | patient A | 
      | 2  | patient B |
      | 3  | patient C | 

    Given the following registrations exist:
      | time_start | time_end   | patient_status | patient_id | registrar_id |
      | 7 days ago | 7 days ago | returning      | 1          | 1            |
      | 5 days ago | 4 days ago |                | 2          | 2            |
      | 4 days ago | 4 days ago | new            | 3          | 1            |
      | 3 days ago | 1 day ago  | returning      | 1          | 1            |
      | 1 day ago  |            | returning      | 2          | 1            |

    Given the following registrars exist:
      | id | name  |
      | 1  | Reg A |
      | 2  | Reg B | 

Scenario: I want to see all of the patients that have been registered in the past 6 days
    Given I am on the overall registration dashboard
    When I set the time restriction to 6 days
    Then I should see "patient A" with starting time "3 days ago"
    And I should not see "patient A" with starting time "7 days ago"
    And I should see "patient B" with starting time "5 days ago"
  
Scenario: I want to see all the patients I have registered in the past 6 days
    Given I am on the Reg A registration dashboard
    When I set the time restriction to 4 days
    Then should not see "patient B" with starting time "5 days ago"
    And I should see "patient B" with starting time "1 day ago"

Scenario: no patients in table result in notification
    Given that I am on the Reg B registration dashboard
    When I set the time restriction to 3 days
    Then I should see a missing patients notification 
