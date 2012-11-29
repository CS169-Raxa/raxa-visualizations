Feature: show the number of patients currently assigned to each doctor

  As a hospital screener,
  I want to view the current distribution of patients to doctors
  so I can ensure workload is being distributed evenly.

Background:

  Given the following doctors exist:
  | name          | specialty             | max_workload | number of patients |
  | Frankenstein  | mad science           |            1 |                  1 |
  | Horrible      | mad science, NPH      |           25 |                  5 |
  | Doogie Howser | resident surgeon, NPH |           12 |                  8 |

  And I am on the screener dashboard

Scenario: see correct number of patients per doctor
  Then Frankenstein should have 1 patient assigned
  And Horrible sohuld have 5 patients assigned
  And Doogie Howser should have 8 patients assigned
