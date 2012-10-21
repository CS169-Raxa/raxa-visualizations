# Drug & related models

Given /^the following drugs exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |drug|
    # each returned element will be a hash whose key is the table header.
    # add that drug to the database here.
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

# Low stock checks

When /^I manually set the low stock point for "(.*?)" to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  visit('/pharmacy')
  click_link("#{name}")
  fill_in('alert_field', :with => amt)
  click_button('Update')
end

Then /^the low stock point for "(.*?)" should be (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  assert_equal(amt, drug.low_stock_point)
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
  assert_equal(0, drug.alert_level)
end

Then /^the low stock alert for "(.*?)" should be on$/ do |name|
  drug = Drug.find_by_name(name)
  assert_equal(1, drug.alert_level)
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
end
