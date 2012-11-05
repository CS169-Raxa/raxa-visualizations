Feature: show total number of patients registered today on overall registration dashboard

  As a registration worker,
  I want to see the overall number of patients registered today,
  So that I can keep track of the overall progress for today

  Background: registrations have occurred
    Given the following patients exist:
      | name      |
      | patient A |
      | patient B |
      | patient C |
      | patient D |
      | patient E |
      | patient F |

    And the following registrars exist:
      | name  |
      | Reg A |
      | Reg B |

    And the following registrations exist:
      | time_start          | time_end            | patient_status | patient_name | registrar_name |
      | today 8:00 am       | today 8:20 am       | returning      | patient A    | Reg A          |
      | today 9:00 am       | today 9:20 am       | new            | patient B    | Reg B          |
      | today 10:00 am      | today 10:20 am      | new            | patient C    | Reg A          |
      | today 10:20 am      | today 10:40 am      | returning      | patient D    | Reg A          |
      | today 12:00 pm      | today 12:20 pm      | returning      | patient E    | Reg A          |
      | today 1:00 pm       | today 1:20 pm       | returning      | patient F    | Reg A          |
      | 1 days ago 1:00 pm  | 1 days ago 1:20 pm  | returning      | patient F    | Reg A          |

    Given I am on the overall registration dashboard

  Scenario: show num patients registered for today
    Then I should see that 6 patients were registered today

  Scenario: update number shown after information about a completed registration is received
    When Reg A registers a patient
    And I am on the overall registration dashboard
    Then I should see that 7 patients were registered today

  Scenario: reset number to zero at the end of the day
    When it is the next day
    And I am on the overall registration dashboard
    Then I should see that 0 patients were registered today
