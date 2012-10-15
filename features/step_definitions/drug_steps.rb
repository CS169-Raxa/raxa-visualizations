# Drug & related models

Given /^the following drugs exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |drug|
    # each returned element will be a hash whose key is the table header.
    # add that movie to the database here.
    Drug.create(drug)
  end
end

Given /^the following drug deltas exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

# Paths

When /^I am on the pharmacy dashboard$/ do
  visit('/pharmacy')
end

# Low Stock Stuff

When /^I manually set the low stock point for "(.*?)" to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  visit('/#{drug.id}/edit')
  fill_in('Low Stock Point', :with => amt)
  click_button('submit')
end

Then /^the low stock point for "(.*?)" should be (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  assert_equal(amt, drug.low_stock_point)
end

When /^I automatically set the low stock point for "(.*?)" to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  drug.low_stock_point = amt
end

module AlertText
  def alert(drugName)
    return 'Low stock for #{drugName}'
  end
end

Then /^I should see an alert for "(.*?)"$/ do |name|
  assert_match(/#{alert(name)}/m, page.body)
end

Then /^I should not see an alert for "(.*?)"$/ do |name|
  assert page.has_no_content(alert(name))
end

When /^the quantity of "(.*?)" is set to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  drug.quantity = amt
end

Then /^the low stock alert for "(.*?)" should be off$/ do |name|
  drug = Drug.find_by_name(name)
  assert_equal(False, drug.low_stock_alert)
end

Then /^the low stock alert for "(.*?)" should be on$/ do |arg1|
  drug = Drug.find_by_name(name)
  assert_equal(True, drug.low_stock_alert)
end

When /^the low stock point of "(.*?)" is set to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  drug.low_stock_point = amt
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
