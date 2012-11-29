Feature: filter displayed doctors by specialty

  As a hospital screener,
  I want to filter the displayed doctors by specialty
  so I can compare only the workloads of doctors with certain skills.

Background:

  Given the following doctors exist:
  | name          | specialty             | max_workload | number of patients |
  | Frankenstein  | Mad Science           |            1 |                  1 |
  | Horrible      | Mad Science, NPH      |           25 |                  5 |
  | Doogie Howser | Resident Surgeon, NPH |           12 |                  8 |

  And I am on the screener dashboard

Scenario: doctors not filtered
  When I filter by "All"
  Then I should see the following doctors: Frankenstein, Horrible, Doogie Howser

Scenario: doctors filtered by specialty
  When I filter by "Mad Science"
  Then I should see the following doctors: Frankenstein, Horrible
  And I should not see the following doctors: Doogie Howser

