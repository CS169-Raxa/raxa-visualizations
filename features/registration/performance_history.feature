Feature: See a table of the patients I have registered

As a registration worker
I want to see a line graph of the number of patients I've registered per day
So that I can see trends in my efficiency

Background: Some patients have been registered 
    Given the following patients exist:
      | id | name      | 
      | 1  | patient A | 
      | 2  | patient B |
      | 3  | patient C | 

    And the following registrations exist:
      | time_start | time_end   | patient_status | patient_id | registrar_id |
      | 7 days ago | 7 days ago | returning      | 1          | 1            |
      | 5 days ago | 4 days ago |                | 1          | 2            |
      | 4 days ago | 4 days ago | new            | 3          | 1            |
      | 3 days ago | 1 day ago  | returning      | 2          | 1            |
      | 1 day ago  |            | returning      | 2          | 1            |

    And the following registrars exist:
      | id | name  |
      | 1  | Reg A |
      | 2  | Reg B | 

    And I am on the Reg A performance metrics page

Scenario: show line graph of metrics for all of my past patients 
    Then I should see a graph of five patients

Scenario: show line graph of metrics for all of my past patients in the last 4 days
    When I set the time restriction to 4 days
    Then I should see a graph of three patients 
    And I should not see "patient A" 

Scenario: don't show line graph when there are no patients
    When I set the time restriction to 2 hours
    Then I should see a missing patients notification
