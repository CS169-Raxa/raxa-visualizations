# general
Given /^the following patients exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |patient|
    Patient.create(patient)
  end
end

Given /^the following registrars exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |registrar|
    Registrar.create(registrar)
  end
end

Given /^the following registrations exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |registration|
    Registration.create(registration)
  end
end

# paths
Given /^I am on the (.*?) registration dashboard$/ do |arg|
  pending # express the regexp above with the code you wish you had
end

# num patients registered
When /^(.*?) registers a patient$/ do |arg|
  pending # express the regexp above with the code you wish you had
end

When /^I register a patient$/ do
  pending # express the regexp above with the code you wish you had
end

When /^it is the next day$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see that (\d+) patients were registered today$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

# avg time to register a patient
Then /^I should see that the average time to register a patient is (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^(.*?) registers a patient from (.*) to (.*)$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end
