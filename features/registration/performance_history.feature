Feature: See a table of the patients I have registered

As a registration worker
I want to see a line graph of the number of patients I've registered per day
So that I can see trends in my efficiency

Background: Some patients have been registered
    Given the following patients exist:
      | name      |
      | Patient A |
      | Patient B |
      | Patient C |

    Given the following registrars exist:
      | name  |
      | Reg A |
      | Reg B |

Scenario: show line graph of metrics for all of my past patients in the past week
    Given the following registrations exist:
      | time_start         | time_end            | patient_status | patient_name | registrar_name |
      | 7 days ago 2:00 am | 7 days ago 1:00 pm  | returning      | Patient A    | Reg A          |
      | 5 days ago 2:00 am | 4 days ago 2:00 am  | returning      | Patient B    | Reg B          |
      | 4 days ago 1:00 am | 4 days ago 2:00 am  | new            | Patient C    | Reg A          |
      | 3 days ago 2:00 am | 1 day ago  2:00 am  | returning      | Patient A    | Reg A          |
      | 1 day ago  2:00 am | 1 day ago  3:00 am  | returning      | Patient B    | Reg A          |
    And I am on the Reg A registration dashboard
    Then I should see a line graph
