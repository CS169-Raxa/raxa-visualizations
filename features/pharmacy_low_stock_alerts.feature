Feature: display alert when stock is low (in pharmacy)

  As a pharmacist
  I want to set alerts that warn me when drug stock falls below a certain quantity
  So that I know to order more

Background: drugs in database

  Given the following drugs exist:
  | name    | quantity | units      | calculated_usage_rate | static_usage_rate | low_stock_point | low_stock_alert |
  | drug1   |     1000 | milligram  |                    50 |                   |             500 | False           |
  | drug2   |     3205 | pack       |                    30 |                   |             300 | False           |
  | drug3   |      255 | pill       |                   100 |                   |            1000 | True            |

Scenario: manually set the low stock point for an existing drug
  When I manually set the low stock point for "drug2" to 200
  Then the low stock point for "drug2" should be 200

Scenario: automatically set the low stock point for an existing drug
  When I automatically set the low stock point for "drug2" to 200
  Then the low stock point for "drug2" should be 200

Scenario: display alert when quantity of a drug is below its low stock point
  When I am on the pharmacy dashboard
  Then I should see an alert for "drug3"

Scenario: don't display alerts for drugs that are not low
  When I am on the pharmacy dashboard
  Then I should not see an alert for "drug1"
  And I should not see an alert for "drug2"

Scenario: update low stock alert status when drug stock changes
  When the quantity of "drug1" is set to 800
  Then the low stock alert for "drug1" should be off
  When the quantity of "drug2" is set to 200
  Then the low stock alert for "drug2" should be on
  When the quantity of "drug3" is set to 1001
  Then the low stock alert for "drug3" should be off

Scenario: update low stock alert status when drug low stock point chagnes
  When the low stock point of "drug1" is set to 800
  Then the low stock alert for "drug1" should be off
  When the low stock point of "drug2" is set to 4000
  Then the low stock alert for "drug2" should be on
  When the low stock point of "drug3" is set to 50
  Then the low stock alert for "drug3" should be off

Scenario: set low stock alert to True if quantity is less than or equal to low stock point
  When the quantity of "drug2" is set to 300
  Then the low stock alert for "drug2" should be on
  And the low stock alert for "drug3" should be on
