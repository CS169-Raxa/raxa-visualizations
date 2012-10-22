Feature: Override estimates of drug usage rates

  As a pharmacist
  I want to override the calculated estimates for usage rates
  So that I can ensure all "time remaining" estimates are accurate

  Background: drugs have been added to database, pharmacist is logged in
    Given the following drugs exist:
      | id | name   | quantity | units | user_rate | low_stock_point |
      | 1  | drug A | 20       | pills |           | 20              |
      | 2  | drug B | 20       | pills |           | 10              |
    Given the following drug deltas exist:
      | drug_name | amount | description         | timestamp  |
      |    drug A |    -70 | something           | 2 days ago |
      |    drug B |    -70 | something           | 2 days ago |
    And I am on the pharmacy dashboard

  Scenario: pharmacy page should use the set usage rate instead of the calculate usage rate
    Then "drug A" should have "2 days" left
    And  "drug B" should have "2 days" left
    When I change the usage rate for "drug A" to "20"
    Then "drug A" should have "7 days" left
    And  "drug B" should have "2 days" left

  Scenario: pharmacy page should revert to calculated estimates when manual estimates are reset
    Given I have changed the usage rate for "drug A" to "20"
    When I reset the usage rate for "drug A"
    Then "drug A" should have "2 days" left
