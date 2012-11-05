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
      | Patient K |
      | Patient L |
      | Patient M |
      | Patient N |
      | Patient O |
      | Patient P |
      | Patient Q |
      | Patient R |
      | Patient S |
      | Patient T |
      | Patient U |
      | Patient V |

    Given the following registrars exist:
      | name  |
      | Reg A |
      | Reg B |

    Given the following registrations exist:
      | time_start          | time_end            | patient_status | patient_name | registrar_name |
      | today 10:00 am      | today 1:00 pm       | returning      | Patient A    | Reg A          |
      | today 1:00 pm       | today 2:00 pm       | new            | Patient B    | Reg A          |
      | today 2:00 pm       | today 4:00 pm       | returning      | Patient C    | Reg A          |
      | today 5:00 pm       | today 6:00 pm       | returning      | Patient D    | Reg A          |
      | today 10:00 pm      | today 10:30 pm      | returning      | Patient E    | Reg A          |
      | yesterday 10:00 am  | yesterday 10:00 am  | new            | Patient F    | Reg A          |
      | yesterday 3:00 pm   | yesterday 5:00 pm   | new            | Patient G    | Reg A          |
      | yesterday 7:00 pm   | yesterday 8:00 pm   | new            | Patient H    | Reg A          |
      | 2 days ago 10:00 am | 2 days ago 1:00 pm  | returning      | Patient I    | Reg A          |
      | 2 days ago 1:00 pm  | 2 days ago 2:00 pm  | returning      | Patient J    | Reg A          |
      | today 2:00pm        | today 5:00 pm       | returning      | Patient K    | Reg B          |
      | today 10:00 pm      | today 10:30 pm      | returning      | Patient L    | Reg B          |
      | today 1:00 am       | today 10:00 am      | returning      | Patient M    | Reg B          |
      | yesterday 10:00 am  | yesterday 10:00 am  | returning      | Patient N    | Reg B          |
      | yesterday 10:00 am  | yesterday 1:00 pm   | new            | Patient O    | Reg B          |
      | 5 days ago 1:00 pm  | 5 days ago 10:30 pm | returning      | Patient P    | Reg A          |
      | 5 days ago 1:00 pm  | 5 days ago 10:30 pm | returning      | Patient Q    | Reg A          |
      | 5 days ago 10:00 pm | 5 days ago 10:30 pm | returning      | Patient R    | Reg A          |
      | 7 days ago 10:00 am | 7 days ago 10:00 am | returning      | Patient S    | Reg A          |
      | 7 days ago 10:00 am | 7 days ago 1:00 pm  | new            | Patient T    | Reg A          |
      | 7 days ago 1:00 pm  | 7 days ago 2:00 pm  | returning      | Patient U    | Reg A          |
      | 7 days ago 3:00 pm  | 7 days ago 5:00 pm  | returning      | Patient V    | Reg A          |

    And I am on the Reg A registration dashboard

Scenario: show time reigstered (end time), patient name, and status for a registration
    Then I should see patient "Patient A" with time "1:00 pm" and status "returning"
    And I should see patient "Patient B" with time "2:00 pm" and status "new"

Scenario: by default, show last 10 patients registered
    Then I should see the following patients: Patient A,Patient B,Patient C
    And I should see the following patients: Patient D,Patient E,Patient F
    And I should see the following patients: Patient G,Patient H,Patient I,Patient J
    But I should not see the following patients: Patient K,Patient L,Patient M
    But I should not see the following patients: Patient N,Patient O,Patient P
    But I should not see the following patients: Patient Q,Patient R,Patient S
    But I should not see the following patients: Patient T,Patient U,Patient V

Scenario: see more, shows more registrations
    When I click SEE MORE
    Then I should see the following patients: Patient A,Patient B,Patient C
    And I should see the following patients: Patient D,Patient E,Patient F
    And I should see the following patients: Patient G,Patient H,Patient I
    And I should see the following patients: Patient J,Patient P,Patient Q
    And I should see the following patients: Patient R,Patient S,Patient T
    And I should see the following patients: Patient U,Patient V
    But I should not see the following patients: Patient K,Patient L, Patient M, Patient N, Patient O

Scenario: table sorted by registration end times, then patient name
    Then I should list "Patient E" before "Patient D"
    And I should list "Patient D" before "Patient C"
    And I should list "Patient C" before "Patient B"
    And I should list "Patient B" before "Patient A"
    And I should list "Patient E" before "Patient H"
    And I should list "Patient H" before "Patient G"
    And I should list "Patient G" before "Patient F"

Scenario: show date header for yesterday
    Then I should see "Patient A" before the "yesterday" header
    And I should see the "yesterday" header before "Patient H"

Scenario: show date header by date
    Then I should see "Patient F" before the "2 days ago" header
    And I should see the "2 days ago" header before "Patient J"
