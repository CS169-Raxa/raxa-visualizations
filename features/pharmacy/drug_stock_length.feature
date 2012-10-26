Feature: Estimate how long drug stock will last

  As a pharmacist
  I want to see estimates for how long current stock will last based on previous usage rates
  so that I can tell when stocks will run out

Background: drugs have been added to database, pharmacist is logged in

  Given the following drugs exist:
  | id | name  | quantity | units     | user_rate | alert_level |
  |  1 | drug1 |     1000 | milligram |           |         500 |
  |  2 | drug2 |     3205 | pack      |           |         300 |
  |  3 | drug3 |       10 | pill      |           |         100 |

  And the following drug deltas exist:
  | drug_name | amount | description         | timestamp    |
  |   drug1   |   -500 | initial supply      | 2 days ago   |
  |   drug1   |   -500 | initial supply      | 1 day ago    |
  |   drug3   |   +200 | reinforcements      | 15 days ago  |
  |   drug3   |   -990 | patient consumption | 1 day ago    |

  And I am on the pharmacy dashboard

  Scenario: pharmacy page should show drug name and estimated time left based off of estimated rate of usage
    Then I should see "drug1"
    And "drug1" should have "7 days" left
    And "drug3" should have "2 hours" left

  Scenario: drugs with missing information can't caluculate estimated time left
    Then "drug2" should not have enough information to estimate the time left
