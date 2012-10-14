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

Scenario: manually set the low_stock_point for an existing drug
  When I manually set the low_stock_point for "drug2" to 200
  Then the low_stock_point for "drug2" should be 200

Scenario: automatically set the low_stock_point for an existing drug
  When I automatically set the low_stock_point for "drug2" to 200
  Then the low_stock_point for "drug2" should be 200

Scenario: display alert when quantity of a drug is below its low_stock_point
  When I am on the pharmacy dashboard
  Then I should see an alert for "drug3"

Scenario: don't display alerts for drugs that are not low
  When I am on the pharmacy dashboard
  Then I should not see an alert for "drug1"
  And I should not see an alert for "drug2"

Scenario: update low_stock_alert status when drug stock changes
  When the quantity of "drug1" is set to 800
  Then the low_stock_alert for "drug1" should be False
  When the quantity of "drug2" is set to 200
  Then the low_stock_alert for "drug2" should be True
  When the quantity of "drug3" is set to 1001
  Then the low_stock_alert for "drug3" should be False

Scenario: set low_stock_alert to True if quantity is less than or equal to low_stock_point
  When the quantity of "drug2" is set to 300
  Then the low_stock_alert for "drug2" should be True
  And the low_stock_alert for "drug3" should be True

Scenario: update low_stock_alert status when drug low_stock_point chagnes
  When the low_stock_point of "drug1" is set to 800
  Then the low_stock_alert for "drug1" should be False
  When the low_stock_point of "drug2" is set to 4000
  Then the low_stock_alert for "drug2" should be True
  When the low_stock_point of "drug3" is set to 50
  Then the low_stock_alert for "drug3" should be False

Scenario: set low_stock_alert to True if quantity is less than or equal to low_stock_point
  When the quantity of "drug2" is set to 300
  Then the low_stock_alert for "drug2" should be True
  And the low_stock_alert for "drug3" should be True