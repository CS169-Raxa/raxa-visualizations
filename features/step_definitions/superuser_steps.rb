Given /^I am on the superuser dashboard$/ do
  visit '/superuser'
end


When /^I click on the "(.*?)" stage$/ do |arg1|
  if not Department.find_by_name(dept)
    Department.create!({:name => dept})
  end
  click_link(arg1)
end

Then /^I should see an average time of (\d+) minutes per patient$/ do |minutes|
  find('#average_time').text.should include "#{minutes}:00"
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a graph$/ do
  page.should have_selector("svg")
end

Then /^there should be (\d+) data items on the graph with averages: (.*)$/ do |num, avgs_list|
  avgs_list = avgs_list.split(/,/).map{ |avg| Integer(avg.strip)}
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a "(.*?)" for average time per patient$/ do |arg1|
  find('#average-time').text.should include arg1
end

Then /^I should not see a graph$/ do
  page.should_not have_selector("svg")
end

require 'cucumber/rspec/doubles'

Given /^the average (.*?) time is (\d+) minutes$/ do |dept, minutes|
  department = Department.find_by_name(dept) || Department.create!({:name => dept})
  department.should_receive(:average_time).and_return(ChronicDuration::parse("#{minutes} minutes"))
end


Given /^(.*?) has been in (.*?) for (\d+) minutes$/ do |patient, dept, minutes|
  encounter = {:start_time => Chronic::parse("#{minutes} minutes ago")}
  e = Encounter.create!(encounter)
  Patient.find_by_name(patient).encounters << e
  Department.find_by_name(dept).encounters << e
end

Then /^I should see an abnormal delay alert for (.*?)$/ do |patient|
  pending # express the regexp above with the code you wish you had
end

Then /^I should not see an abnormal delay alert for (.*?)$/ do |patient|
  pending # express the regexp above with the code you wish you had
end

When /^I look at the timeline for (.*?)$/ do |patient|
  pending # express the regexp above with the code you wish you had
end

Then /^first I should see a (.*?) block for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^then I should see a (.*?) block for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^last I should see an (.*?) block for (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
