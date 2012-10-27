Feature: show total number of patients registered today on overall registration dashboard

  As a registration worker,
  I want to see the overall number of patients registered today,
  So that I can keep track of the overall progress for today

  Background: registrations have occurred
    Given the following patients exist:
      | id | name      |
      | 1  | patient A |
      | 2  | patient B |
      | 3  | patient C |
      | 4  | patient D |
      | 5  | patient E |
      | 6  | patient F |

    And the following registrars exist:
      | id | name  |
      | 1  | Reg A |
      | 2  | Reg B |

    And the following registrations exist:
      | time_start       | time_end         | patient_status | patient_id | registrar_id |
      | 2010-10-10 08:00 | 2010-10-10 08:20 | returning      | 1          | 1            |
      | 2010-10-10 09:00 | 2010-10-10 09:20 | new            | 2          | 2            |
      | 2010-10-10 10:00 | 2010-10-10 10:20 | new            | 3          | 1            |
      | 2010-10-10 11:00 | 2010-10-10 11:20 | returning      | 4          | 1            |
      | 2010-10-10 12:00 | 2010-10-10 12:20 | returning      | 5          | 1            |
      | 2010-10-10 13:00 | 2010-10-10 13:20 | returning      | 6          | 1            |

    Given I am on the overall registration dashboard
    And the date is 2010-10-10

  Scenario: show num patients registered for today
    Then I should see that 6 patients were registered today

  Scenario: update number shown after information about a completed registration is received
    When Reg A registers a patient
    Then I should see that 7 patients were registered today

  Scenario: reset number to zero at the end of the day
    When it is the next day
    Then I should see that 0 patients were registered today
