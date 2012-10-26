Feature: display alert when stock is low (in pharmacy)

  As a pharmacist
  I want to set and see alerts that warn me when drug stock falls below a certain quantity
  So that I know to order more

Background: drugs in database

  Given the following drugs exist:
  | name  | quantity | units     | alert_level |
  | drug1 |     1000 | milligram |         500 |
  | drug2 |     3205 | pack      |         300 |
  | drug3 |      255 | pill      |        1000 |

Scenario: set the alert level for an existing drug
  When I set the alert level of "drug2" to 200
  Then the alert level for "drug2" should be 200

Scenario: display alert when quantity of a drug is below its alert level
  When I am on the pharmacy dashboard
  Then I should see an alert for "drug3"

Scenario: don't display alerts for drugs that are not low
  When I am on the pharmacy dashboard
  Then I should not see an alert for "drug1"
  And I should not see an alert for "drug2"

Scenario: update low stock alert status when drug stock changes from above to above alert level
  When the quantity of "drug1" is set to 800
  Then I should not see an alert for "drug1"

Scenario: update low stock alert status when drug stock changes from above to under alert level
  When the quantity of "drug2" is set to 200
  Then I should see an alert for "drug2"

Scenario: update low stock alert status when drug stock changes from under to above alert level
  When the quantity of "drug3" is set to 1001
  Then I should not see an alert for "drug3"

Scenario: update low stock alert status when drug alert level changes from under to under stock quantity
  When I set the alert level of "drug1" to 800
  Then I should not see an alert for "drug1"

Scenario: update low stock alert status when drug alert level changes from above to under stock quantity
  When I set the alert level of "drug2" to 4000
  Then I should not see an alert for "drug1"

Scenario: update low stock alert status when drug alert level changes from under to above stock quantity
  When I set the alert level of "drug3" to 50
  Then I should not see an alert for "drug3"

Scenario: see low stock alert if quantity is less than or equal to alert level
  When the quantity of "drug2" is set to 300
  Then I should see an alert for "drug2"
