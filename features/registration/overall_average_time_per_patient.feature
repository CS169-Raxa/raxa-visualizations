Feature: show average time to register a patient on registration dashboard

  As a registration worker,
  I want to see the overall average time spent registering a patient,
  So that I can estimate how long patients will take and know if a patient is taking more or less time than usual

  Background: registrations have occurred
    Given the following patients exist:
      | name      |
      | patient A |
      | patient B |
      | patient C |
      | patient D |
      | patient E |

    And the following registrars exist:
      | name  |
      | Reg A |
      | Reg B |

    And the following registrations exist:
      | time_start          | time_end            | patient_status | patient_name | registrar_name |
      | today 8:00 am       | today 8:10 am       | returning      | patient A    | Reg A          |
      | 1 day ago 9:00 am   | 1 day ago 9:15 am   | new            | patient B    | Reg B          |
      | today 10:00 am      | today 10:20 am      | new            | patient C    | Reg A          |
      | 2 days ago 10:20 am | 2 days ago 10:35 am | returning      | patient D    | Reg A          |
      | today 12:00 pm      | today 12:10 pm      | returning      | patient E    | Reg A          |
      | 3 days ago 1:00 pm  | 3 days ago 1:20 pm  | returning      | patient B    | Reg A          |

    Given I am on the overall registration dashboard

  Scenario: should see average time to register a patient on the overall dashboard
    Then I should see that the average time to register a patient is 15 minutes

  Scenario: average time to register a patient should change after adding a new registration
    When Reg A registers a new patient from today 2:00 pm to today 2:08 pm
    And I am on the overall registration dashboard
    Then I should see that the average time to register a patient is 14 minutes

