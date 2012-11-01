Feature: See a table of the patients I have registered

  As a registration worker
  I want to see a table of all patients registered (with their status of new/returning and time registered) listed by how recently they were registered,
  So that I can keep track of what patients I have registered today and in previous days.

Background: Some patients have been registered
    Given the following patients exist:
      | name      |
      | Patient A |
      | Patient B |
      | Patient C |
      | Patient D |
      | Patient E |
      | Patient F |
      | Patient G |
      | Patient H |
      | Patient I |
      | Patient J |

    Given the following registrars exist:
      | name  |
      | Reg A |
      | Reg B |

    Given the following registrations exist:
      | time_start          | time_end            | patient_status | patient_name | registrar_name |
      | today 11:00 am      | today 1:00 pm       | returning      | Patient A    | Reg A          |
      | today 1:00 pm       | today 2:00 pm       | new            | Patient B    | Reg A          |
      | today 2:00 pm       | today 4:00 pm       | returning      | Patient C    | Reg A          |
      | today 5:00 pm       | today 6:00 pm       | returning      | Patient D    | Reg A          |
      | today 10:00 pm      | today 11:00 pm      | returning      | Patient E    | Reg A          |
      | yesterday 10:00 am  | yesterday 11:00 am  | new            | Patient F    | Reg B          |
      | yesterday 3:00 pm   | yesterday 5:00 pm   | new            | Patient G    | Reg B          |
      | yesterday 7:00 pm   | yesterday 8:00 pm   | new            | Patient H    | Reg B          |
      | 1 day ago  11:00 am | 1 day ago 1:00 pm   | returning      | Patient I    | Reg A          |
      | 1 day ago  1:00 pm  | 1 day ago 2:00 pm   | returning      | Patient J    | Reg A          |
      | 1 day ago  2:00pm   | 1 day ago 5:00 pm   | returning      | Patient A    | Reg A          |
      | 1 day ago  10:00 pm | 1 day ago 11:00 pm  | returning      | Patient B    | Reg A          |
      | 2 days ago 1:00 am  | 2 days ago 11:00 am | returning      | Patient C    | Reg A          |
      | 3 days ago 10:00 am | 3 day ago  11:00 am | returning      | Patient D    | Reg B          |
      | 5 days ago 11:00 am | 5 day ago  1:00 pm  | returning      | Patient E    | Reg B          |
      | 5 days ago 1:00 pm  | 5 day ago  11:00 pm | returning      | Patient F    | Reg B          |
      | 5 days ago 1:00 pm  | 5 day ago  11:00 pm | returning      | Patient G    | Reg A          |
      | 5 days ago 10:00 pm | 5 day ago  11:00 pm | returning      | Patient H    | Reg A          |
      | 7 days ago 10:00 am | 7 day ago  11:00 am | returning      | Patient I    | Reg A          |
      | 7 days ago 11:00 am | 7 day ago  1:00 pm  | returning      | Patient J    | Reg A          |
      | 7 days ago 1:00 pm  | 7 day ago  2:00 pm  | returning      | Patient A    | Reg A          |
      | 7 days ago 3:00 pm  | 7 day ago  5:00 pm  | returning      | Patient B    | Reg A          |

    And I am on the overall registration dashboard

Scenario: by default, show last 10 patients registered

Scenario: see more, shows 10 more registrations

Scenario: at end of registrations in history, show all

Scenario: show notification if no Patients in table

Scenario: table sorted by registration end times, then patient name

Scenario: show date header for yesterday

Scenario: show date header by date

"""
Scenario: I want to see all of the Patients that have been registered in the past 6 days
    Given I am on the overall registration dashboard
    When I set the time restriction to "6 days"
    Then I should see "Patient A" with starting time "3 days ago"
    And I should not see "Patient A" with starting time "7 days ago"
    And I should see "Patient B" with starting time "5 days ago"
    And "Patient B" should have status "new"

Scenario: I want to see all the Patients I have registered in the past 6 days
    Given I am on the Reg A registration dashboard
    When I set the time restriction to "4 days"
    Then should not see "Patient B" with starting time "5 days ago"
    And I should see "Patient B" with starting time "1 day ago"

Scenario: no Patients in table result in notification
    Given I am on the Reg B registration dashboard
    When I set the time restriction to "3 days"
    Then I should see a missing patients notification

Scenario: table should be sorted by how recently they checked in.
    Given I am on the overall registration dashboard
    When I set the time restriction to "4 days"
    Then I should see "Patient B" before "Patient A"
    And I should see "Patient A" before "Patient C"
"""
