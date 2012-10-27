Feature: show average time to register a patient on registration dashboard

  As a registration worker,
  I want to see the  average time I spend registering a patient,
  So that I can estimate how long patients will take and know if a patient is taking more or less time than usual, according to my personal average

  Background: registrations have occurred
    Given the following patients exist:
      | id | name      |
      | 1  | patient A |
      | 2  | patient B |
      | 3  | patient C |
      | 4  | patient D |
      | 5  | patient E |

    And the following registrars exist:
      | id | name  |
      | 1  | Reg A |
      | 2  | Reg B |

    And the following registrations exist:
      | time_start       | time_end         | patient_status | patient_id | registrar_id |
      | 2010-10-10 08:00 | 2010-10-10 08:10 | returning      | 1          | 1            |
      | 2010-10-11 09:00 | 2010-11-10 09:15 | new            | 2          | 2            |
      | 2010-10-10 10:00 | 2010-10-10 10:20 | new            | 3          | 1            |
      | 2010-10-12 11:00 | 2010-12-10 11:15 | returning      | 4          | 1            |
      | 2010-10-10 12:00 | 2010-10-10 12:10 | returning      | 5          | 1            |
      | 2010-10-13 13:00 | 2010-13-10 13:20 | returning      | 2          | 1            |

    Given I am on the Reg A registration dashboard

  Scenario: should see average time to register a patient on the overall dashboard
    Then I should see that the average time to register a patient is 15 minutes

  Scenario: average time to register a patient should change after I add a new registration
    When Reg A registers a patient from 2010-10-13 14:00 to 2010-10-13 14:09
    Then I should see that the average time to register a patient is 14 minutes

  Scenario: average time to register a patient should not change after someone else adds a new registration
    When Reg B registers a patient from 2010-10-13 14:00 to 2010-10-14 14:09
    Then I should see that the average time to register a patient is 15 minutes

