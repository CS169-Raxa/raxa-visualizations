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

When /^I manually set the low stock point for "(.*?)" to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  visit('/pharmacy')
  fill_in(:drug, :with => amt)
  click_button('Update')
end

Then /^the low stock point for "(.*?)" should be (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  assert_equal(amt, drug.low_stock_point)
end

Then /^I should see an alert for "(.*?)"$/ do |name|
  assert_match(/#{name}(.*)---/m, page.body)
end

Then /^I should not see an alert for "(.*?)"$/ do |name|
  assert_match(/---(.*)#{name}/m, page.body)
end

When /^the quantity of "(.*?)" is set to (\d+)$/ do |name, amt|
  drug = Drug.find_by_name(name)
  drug.quantity = amt
  drug.save
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

Then /^"(.*?)" should have (.*?) left/ do |drug_name, time_left|
  drug = Drug.find_by_name(drug_name)
  assert page.find("#drug#{drug.id} .info").should have_content time_left
end

When /^I (have )?change(d)? the usage rate for "(.*?)" to "(.*?)"/ do |_, _, drug_name, override|
  drug = Drug.find_by_name(drug_name)
  fill_in "drug#{drug.id}", :with => override
  click_button 'Update'
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
