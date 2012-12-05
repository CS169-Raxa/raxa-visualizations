Feature: Adjust drog stock usage and alert level independently

  As a pharmacist
  I want to adjust the expected usage rate of a drug and the alert level for the drug independently
  so that I can analyze the rate of usage for a drug without being unnecessarily alerted

Background: drugs have been added to database, pharmacist is logged in

  Given the following drugs exist:
  | id | name  | quantity | units     | user_rate | alert_level |
  |  1 | drug1 |     4000 | milligram |           |        5000 |

  And the following drug deltas exist:
  | drug_name | amount | description         | timestamp    |
  |   drug1   |   -500 | initial supply      | 2 days ago   |
  |   drug1   |   -500 | initial supply      | 1 day ago    |

  And I am on the pharmacy dashboard
    Then I should see "drug1"
    And "drug1" should have "28 days" left
    And I should see an alert for "drug1"

  Scenario: Change usage rate, see no change in alert status
    When I change the usage rate for "drug1" to "2000"
    Then "drug1" should have "14 days" left
    And I should see an alert for "drug1"
