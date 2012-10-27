Feature: See a table of the patients I have registered

  As a registration worker
  I want to see a table of all patients registered (with their status of new/returning and time registered) listed by how recently they were registered,
  So that I can keep track of what patients I have registered today and in previous days.

Background: Some patients have been registered 
    Given the following patients exist:
      | id | name      | 
      | 1  | Patient A | 
      | 2  | Patient B |
      | 3  | Patient C | 

    Given the following registrars exist:
      | id | name  |
      | 1  | Reg A |
      | 2  | Reg B | 

    Given the following registrations exist:
      | time_start          | time_end            | patient_status | patient_name | registrar_name |
      | 7 days ago 11:00 am | 7 days ago 1:00 pm  | returning      | Patient A    | Reg A          |
      | 5 days ago 11:00 am | 4 days ago 11:00 am |                | Patient B    | Reg B          |
      | 4 days ago 1:00 am  | 4 days ago 11:00 am | new            | Patient C    | Reg A          |
      | 3 days ago 11:00 am | 1 day ago  11:00 am | returning      | Patient A    | Reg A          |
      | 1 day ago  11:00 am |                     | returning      | Patient B    | Reg A          |

Scenario: I want to see all of the Patients that have been registered in the past 6 days
    Given I am on the overall registration dashboard
    When I set the time restriction to 6 days
    Then I should see "Patient A" with starting time "3 days ago"
    And I should not see "Patient A" with starting time "7 days ago"
    And I should see "Patient B" with starting time "5 days ago"
    And I should see "Patient B" with Patient status "new"
  
Scenario: I want to see all the Patients I have registered in the past 6 days
    Given I am on the Reg A registration dashboard
    When I set the time restriction to 4 days
    Then should not see "Patient B" with starting time "5 days ago"
    And I should see "Patient B" with starting time "1 day ago"

Scenario: no Patients in table result in notification
    Given I am on the Reg B registration dashboard
    When I set the time restriction to 3 days
    Then I should see a missing patients notification 

Scenario: table should be sorted by how recently they checked in. 
    Given I am on the overall registration dashboard
    When I set the time restriction to 4 days
    Then I should see "Patient B" before "Patient A"
    And I should see "Patient A" before "Patient C"
