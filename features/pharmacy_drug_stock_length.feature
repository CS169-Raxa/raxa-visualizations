Feature: Estimate how long drug stock will last
	
	As a pharmacist
	I want to see estimates for how long current stock will last based on previous usage rates
	so that I can tell when stocks will run out

Background: drugs have been added to database, pharmacist is logged in
	
	Given the following drugs exist:
	| name   | quantity | units | calculated_usage_rate | low_stock_alert |
	| drug A | 50       | pills | 10 per day            | 10              |
	| drug B | 30       | pills | 20 per day            | 40              |
	| drug C | 10       | pills | 20 per day            | 40              |
	| drug D |          |       | 20 per day            | 40              |
	| drug E | 10       | pills |                       | 40              |
	| drug F | 5        | pills	| 10 per day            | 			      | 
		
	And I am logged in as a pharmacist
	And I am on the pharmacy page

Scenario: pharmacy page should show drug name and estimated time left based off of estimated rate of usage
	Then I should see "drug A"
	And next to "drug A" I should see "5 days left"
	And next to "drug A" I should not see "10 pills/day"
	And I should see "drug B"
	And next to "drug B" I should see "1 days left"
	And I should see "drug C"
	And next to "drug C" I should see "0 days left"
	And I should see "drug F"
	And next to "drug F" I should see "0 days left"

Scenario: drugs with missing information can't caluculate estimated time left
	Then I should see "drug D"
	And next to "drug D" I should see "Not enough information to estimate time left"
	And I should see "drug E"
	And next to "drug E" I should see "Not enough information to estimate time left"

Scenario: only see an alert when stock is running low
	Then "drug A" should not have an alert
	And "drug B" should have an alert
	And "drug C" should have an alert
	And "drug F" should not have an alert
