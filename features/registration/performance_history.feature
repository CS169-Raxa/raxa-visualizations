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

    Given the following registrations exist:
      | time_start          | time_end            | patient_status | patient_name | registrar_name |
      | 7 days ago 11:00 am | 7 days ago 1:00 pm  | returning      | Patient A    | Reg A          |
      | 5 days ago 11:00 am | 4 days ago 11:00 am |                | Patient B    | Reg B          |
      | 4 days ago 1:00 am  | 4 days ago 11:00 am | new            | Patient C    | Reg A          |
      | 3 days ago 11:00 am | 1 day ago  11:00 am | returning      | Patient A    | Reg A          |
      | 1 day ago  11:00 am |                     | returning      | Patient B    | Reg A          |

    And I am on the Reg A performance metrics page

Scenario: show line graph of metrics for all of my past patients
    Then I should see a graph of 5 patients

Scenario: show line graph of metrics for all of my past patients in the last 4 days
    When I set the time restriction to "4 days"
    Then I should see a graph of 3 patients
    And I should not see "Patient A"

Scenario: don't show line graph when there are no patients
    When I set the time restriction to "2 hours"
    Then I should see a missing patients notification
