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

    Given the following registrars exist:
      | name  |
      | Reg A |
      | Reg B |

Scenario: on overall dashboard, show notification if no registrations in table
    Given I am on the overall registration dashboard
    Then I should see a no registrations notification

Scenario: on individual dashboard, show notification if no registrations in table
    Given I am on the Reg A registration dashboard
    Then I should see a no registrations notification