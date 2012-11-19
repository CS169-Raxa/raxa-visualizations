require 'cucumber/rspec/doubles'

Given /^I am on the superuser dashboard$/ do
  visit '/superuser'
end

Given /^the (.*?) department exists$/ do |dept|
  if not Department.find_by_name(dept)
    Department.create!({:name => dept})
  end
end

When /^I click on the "(.*?)" stage$/ do |dept|
  click_link(dept)
end

Then /^I should see an average time of (\d+) minutes per patient$/ do |minutes|
  assert_match("#{minutes}:00", page.body)
end

Then /^I should see a graph$/ do
  assert_match("box_plot", page.body)
end

Then /^there should be (\d+) data items on the graph with averages: (.*)$/ do |num, avgs_list|
  avgs_list = avgs_list.split(/,/).map{ |avg| Integer(avg.strip)}
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a "(.*?)" for average time per patient$/ do |arg1|
  assert_match(arg1, page.body)
end

Then /^I should not see a graph$/ do
  print Nokogiri::HTML.parse(page.body).css('svg')
  page.should_not have_content("svg")
end

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

Then /^I should (.*?) see an abnormal delay alert for (.*?)$/ do |arg1, patient|
  pending # express the regexp above with the code you wish you had
end

When /^I look at the timeline for (.*?)$/ do |patient|
  @patient = Patient.find_by_name patient
end

Then /I should see a (.*?) block for (\d+) minutes$/ do |dept, time|
  pending # express the regexp above with the code you wish you had
end

