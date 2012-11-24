Feature: display the number of patients left to assign

  As a hospital screener,
  I want to view the number of patients to assign
  so I can appropriately attend to the task of assigning them to doctors.

Background:

  Given Patients A-F exist
  And I am on the screener dashboard

Scenario: some patients have been assigned
  When Patiends A-D have been assigned
  Then I should see "2 patients to assign"

Scenario: no patients have been assigned
  Then I should see "6 patients to assign"

Scenario: one patient to assign
  When Patients A-E have been assigned
  Then I should see "1 patient to assign"

Scenario: no patients to assign
  When Patients A-F have been assigned
  Then I should see "0 patients to assign"