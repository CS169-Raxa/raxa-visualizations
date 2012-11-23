Feature: show a visualization of the current patient workload for each doctor

  As a hospital screener,
  I want to view the current distribution of patients to doctors
  so I can ensure workload is being distributed evenly.

Background:

  Given the following doctors exist:
  | name          | specialty        | max_workload | number of patients |
  | Frankenstein  | mad science      |            1 |                  1 |
  | Horrible      | mad science      |           25 |                  5 |
  | Doogie Howser | resident surgeon |           12 |                  8 |

  And I am on the screener dashboard

Scenario: see correct workload per doctor
  Then I should see Frankenstein at 100% workload
  Then I should see Horrible at 20% workload
  Then I should see Doogie Howser at 66% workload

Scenario: see doctors in order of workload
  Then I should see Horrible before Doogie Howser
  And I should see Doogie Howser before Frankenstein

