# Drug & related models

Given /^the following drugs exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given /^the following drug deltas exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

# Paths

When /^I am on the pharmacy dashboard$/ do
  pending # express the regexp above with the code you wish you had
end

# Low stock checks

When /^I manually set the low_stock_point for "(.*?)" to (\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the low_stock_pint for "(.*?)" should be (\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When /^I automatically set the low_stock_point for "(.*?)" to (\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an alert for "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see an alert for "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^the quantity of "(.*?)" is set to (\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the low_stock_alert for "(.*?)" should be False$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the low_stock_alert for "(.*?)" should be True$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^the low_stock_point of "(.*?)" is set to (\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

# Sparklines

Then /^I should see a sparkline in the row for drug "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the sparkline should have (\d+) points$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a missing history notification in the row for drug "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a flat sparkline in the row for drug "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
