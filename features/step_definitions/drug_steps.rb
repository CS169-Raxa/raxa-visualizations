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
  table.hashes.each do |drug_delta|
    drug_delta['timestamp'] = Chronic::parse(drug_delta['timestamp'])
    params = {}
    drug_delta.each do |key, value|
      if key != 'drug_id' and key != 'drug_name'
        params[key] = value
      end
    end
    drug = Drug.find_by_name(drug_delta['drug_name'])
    drug.drug_deltas << DrugDelta.create(params)
  end
end

# Paths

When /^I am on the pharmacy dashboard$/ do
  visit('/pharmacy')
end

# Low stock checks

When /^I set the alert level of "(.*?)" to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  visit('/pharmacy')
  find("#drug#{drug.id} .low_stock_point").set(amt)
  click_button('Update')
  puts drug.low_stock_point
  puts drug.alert_level
end

Then /^the alert level for "(.*?)" should be (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  drug.alert_level.should == amt.to_i
end

Then /^I should see an alert for "(.*?)"$/ do |name|
  visit('/pharmacy')
  drug = Drug.find_by_name(name)
  page.should have_selector "#drug#{drug.id} .alert"
end

Then /^I should not see an alert for "(.*?)"$/ do |name|
  visit('/pharmacy')
  drug = Drug.find_by_name(name)
  page.should have_no_selector "#drug#{drug.id} .alert"
end

When /^the quantity of "(.*?)" is set to (\d+)$/ do |name, qty|
  drug = Drug.find_by_name(name)
  drug.quantity = qty
  drug.save
end

# Sparklines

Then /^I should see a sparkline in the row for drug "(.*?)"$/ do |drug_name|
  @drug = Drug.find_by_name drug_name
  page.should have_selector("svg#smallSparkline-#{@drug.id}")
end

Then /^I should see a missing history notification in the row for drug "(.*?)"$/ do |drug_name|
  page.should have_selector("table #drug#{Drug.find_by_name(drug_name).id} .missingSparklineHistory")
end

Then /^I should see a flat sparkline in the row for drug "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

# Override estimates

Then /^"(.*?)" should have "(.*?)" left/ do |drug_name, time_left|
  drug = Drug.find_by_name(drug_name)
  page.find("#drug#{drug.id} .info").should have_content time_left
end

When /^I (?:have )?change(?:d)? the usage rate for "(.*?)" to "(.*?)"/ do |drug_name, override|
  drug = Drug.find_by_name(drug_name)
  find("#user_rate_field-#{drug.id}").set(override)
  click_button "user_rate_submit-#{drug.id}"
end

When /^I reset the usage rate for "(.*)"/ do |drug_name|
  step %Q[I change the usage rate for "#{drug_name}" to ""]
end

Then /^"(.*?)" should not have enough information to estimate the time left$/ do |drug_name|
  drug = Drug.find_by_name(drug_name)
  assert page.find("#drug#{drug.id} .info").should have_content ("Estimate unavailable")
end

Then /^I should see "(.*?)"$/ do |drug|
  page.should have_content(drug)
end
