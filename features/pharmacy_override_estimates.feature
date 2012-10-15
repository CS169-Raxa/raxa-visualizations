Feature: Override estimates of drug usage rates

  As a pharmacist
  I want to override the calculated estimates for usage rates
  So that I can ensure all "time remaining" estimates are accurate

  Background: drugs have been added to database, pharmacist is logged in
    Given the following drugs exist:
      | name   | quantity | units | calculated_usage_rate | low_stock_alert |
      | drug A | 20       | pills | 10 per day            | 20              |
      | drug B | 20       | pills | 10 per day            | 10              |
    And I am logged in as a pharmacist
    And I am on the pharmacy page

  Scenario: pharmacy page should use the set usage rate instead of the calculate usage rate
    Then "drug A" should have 2 days left
    And  "drug B" should have 2 days left
    When I change the usage rate for "drug A" to 20 per day
    Then "drug A" should have 1 day left
    And  "drug B" should have 2 days left

  Scenario: pharmacy page should revert to calculated estimates when manual estimates are reset
    Given I have changed the usage rate for "drug A" to 20 per day
    When I reset the usage rate for "drug A"
    Then "drug A" should have 2 days left
