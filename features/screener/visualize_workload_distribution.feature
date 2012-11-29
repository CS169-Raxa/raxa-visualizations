Feature: show a visualization of the current workload for each doctor

  As a hospital screener,
  I want to view the workload of each doctor
  so I can appropriately choose which doctor to assign a patient.

Background:

  Given the following doctors exist:
  | name          | specialty             | max_workload | number of patients |
  | Frankenstein  | mad science           |            1 |                  1 |
  | Horrible      | mad science, NPH      |           25 |                  5 |
  | Doogie Howser | resident surgeon, NPH |           12 |                  8 |

  And I am on the screener dashboard

Scenario: see correct workload per doctor
  Then I should see doctor Frankenstein at 100% workload
  And I should see doctor Horrible at 20% workload
  And I should see doctor Doogie Howser at 66% workload

Scenario: see doctors in order of workload
  Then I should see Horrible before Doogie Howser
  And I should see Doogie Howser before Frankenstein

