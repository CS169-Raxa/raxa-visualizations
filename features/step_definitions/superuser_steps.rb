Given /^I am on the superuser dashboard$/ do
  visit '/superuser'
end


When /^I click on the "(.*?)" stage$/ do |arg1|
  click_button(arg1)
end

Then /^I should see an average time of (\d+) minutes per patient$/ do |minutes|
  find('#average-time').text.should include "#{minutes}:00"
end

Then /^I should see a graph$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^there should be (\d+) data items on the graph with averages: (\d+),(\d+)$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a "(.*?)" for average time per patient$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see a graph$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^the average wait time is (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^the average registration time is (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^Patient A has been waiting for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^Patient B has been in registration for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see an abnormal delay alert for Patient A$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an abnormal delay alert for Patient B$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see Patient B before Patient A$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I look at the timeline for Patient A$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I look at the timeline for Patient B$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^first I should see a registration block for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^then I should see a wait block for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^then I should see a screening block for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^last I should see an inpatient block for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
