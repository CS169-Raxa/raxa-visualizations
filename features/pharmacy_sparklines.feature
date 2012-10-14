Feature: Drug stock sparklines

  As a pharmacist
  I want to see sparklines of drug stock
  so that I can quickly see usage trends

  https://www.pivotaltracker.com/story/show/37710389

Background: drugs and deltas have been added to the database

  Given the following drugs exist:
  | id | name  | quantity | units     | calculated_usage_rate | static_usage_rate | low_stock_point | low_stock_alert |
  | 1  | drug1 |     1000 | milligram |                    50 |                   |             500 | False           |
  | 2  | drug2 |     3205 | pack      |                    30 |                   |             300 | False           |
  | 3  | drug3 |      255 | pill      |                   100 |                   |            1000 | True            |

  And the following drug deltas exist:
  | drug_id | amount | description         |  timestamp |
  |       3 |   +100 | initial supply      | 2012-10-01 |
  |       3 |   +200 | reinforcements      | 2012-10-15 |
  |       3 |    -45 | patient consumption | 2012-10-20 |

  And I am on the pharmacy dashboard

Scenario: show sparklines indicating drug stock levels

  Then I should see a sparkline in the row for drug "drug3"
  And the sparkline should have 3 points

Scenario: do not show sparklines for drugs without history

  Then I should see a missing history notification in the row for drug "drug2"
  And I should see a missing history notification in the row for drug "drug1"
