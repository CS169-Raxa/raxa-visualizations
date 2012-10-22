Feature: Drug stock sparklines

  As a pharmacist
  I want to see sparklines of drug stock
  so that I can quickly see usage trends

  https://www.pivotaltracker.com/story/show/37710389

Background: drugs and deltas have been added to the database

  Given the following drugs exist:
  | name  | quantity | units     |
  | drug1 |     1000 | milligram |
  | drug2 |     3205 | pack      |
  | drug3 |      255 | pill      |
  | drug4 |      100 | pill      |

  And the following drug deltas exist:
  | drug_name | amount | description         | timestamp  |
  | drug3     |   +100 | initial supply      | 1 day ago  |
  | drug3     |   +200 | reinforcements      | 2 days ago |
  | drug3     |    -45 | patient consumption | 3 days ago |
  | drug4     |   +100 | initial supply      | 1 year ago |

  And I am on the pharmacy dashboard

Scenario: show sparklines indicating drug stock levels

  Then I should see a sparkline in the row for drug "drug3"

Scenario: do not show sparklines for drugs without history

  Then I should see a missing history notification in the row for drug "drug2"
  And I should see a missing history notification in the row for drug "drug1"
