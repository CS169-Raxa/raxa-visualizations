Feature: Drug stock over time graph

  As a pharmacist
  I want to see a detailed graph of drug stock
  So that I can analyze usage trends over the past variable time periods

  https://www.pivotaltracker.com/story/show/38167835

Background: drugs and deltas have been added to the database

  Given the following drugs exist:
  | name  | quantity | units     |
  | drug1 |     1000 | milligram |
  | drug2 |     3205 | pack      |
  | drug3 |      255 | pill      |
  | drug4 |      100 | pill      |

  And the following drug deltas exist:
  | drug_name | amount | description         | timestamp              |
  | drug3     |   +100 | initial supply      | 1 day ago              |
  | drug3     |   +200 | reinforcements      | 2 months ago           |
  | drug3     |   +200 | reinforcements      | 2 months and 1 day ago |
  | drug3     |    -45 | patient consumption | 7 months ago           |
  | drug4     |   +100 | initial supply      | 1 year ago             |

  And I am on the pharmacy dashboard

Scenario: show time graph indicating drug stock levels

  Then I should see a time graph in the row for drug "drug3"

Scenario: do not show sparklines for drugs without history

  Then I should see a time graph missing history notification in the row for drug "drug2"
  And I should see a time graph missing history notification in the row for drug "drug1"
