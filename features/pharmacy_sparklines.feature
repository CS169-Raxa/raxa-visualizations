Feature: Drug stock sparklines

  As a pharmacist
  I want to see sparklines of drug stock
  so that I can quickly see usage trends

  https://www.pivotaltracker.com/story/show/37710389

Background: drugs and deltas have been added to the database

  Given the following drugs exist:
  | name  | quantity | units     | low_stock_point |
  | drug1 |     1000 | milligram |             500 |
  | drug2 |     3205 | pack      |             300 |
  | drug3 |      255 | pill      |            1000 |
  | drug4 |      100 | pill      |              10 |

  And the following drug deltas exist:
  | drug_name | amount | description         | timestamp   |
  | drug3     |   +100 | initial supply      | 1 month ago |
  | drug3     |   +200 | reinforcements      | 15 days ago |
  | drug3     |    -45 | patient consumption | 1 day ago   |
  | drug4     |   +100 | initial supply      | 1 year ago  |

  And I am on the pharmacy dashboard

Scenario: show sparklines indicating drug stock levels

  Then I should see a sparkline in the row for drug "drug3"
  And the sparkline should have 3 points

Scenario: do not show sparklines for drugs without history

  Then I should see a missing history notification in the row for drug "drug2"
  And I should see a missing history notification in the row for drug "drug1"

Scenario: show a flat sparkline for drugs with usage history too far in the past

  Then I should see a flat sparkline in the row for drug "drug4"
