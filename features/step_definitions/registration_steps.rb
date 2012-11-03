require 'cucumber/rspec/doubles'

# general
Given /^the following patients exist:$/ do |table|
  table.hashes.each do |patient|
    Patient.create!(patient)
  end
end

Given /^the following registrars exist:$/ do |table|
  table.hashes.each do |registrar|
    Registrar.create!(registrar)
  end
end

Given /^the following registrations exist:$/ do |table|
  table.hashes.each do |info|
    registrar = Registrar.find_by_name(info[:registrar_name])
    registration = registrar.registrations.create!(
      :time_start => Chronic::parse(info[:time_start]),
      :time_end => Chronic::parse(info[:time_end]),
      :patient_status => info[:patient_status]
    )
    patient = Patient.find_by_name(info[:patient_name])
    patient.registrations << registration
  end
end

# paths
Given /^I am on the (.*?) registration dashboard$/ do |registrar_name|
  if registrar_name == 'overall'
    visit '/registration/registrars'
  else
    registrar = Registrar.find_by_name(registrar_name)
    visit(registration_registrar_path(registrar_id))
  end
end

# num patients registered
When /^(.*?) registers a patient$/ do |registrar_name|
  registrar = Registrar.find_by_name(registrar_name)
  registrar.registrations.create!(:time_start => Time.now - 5.minutes,
                                  :time_end => Time.now)
end

When /^I register a patient$/ do
  pending # express the regexp above with the code you wish you had
end

When /^it is the next day$/ do
  correct_time = Time.method(:now)
  Time.stub(:now) { correct_time.call + 1.day }
end

Then /^I should see that (\d+) patients were registered today$/ do |num|
  find('#num-today').text.should == num
end

# avg time to register a patient
Then /^I should see that the average time to register a patient is (\d+) minutes$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

When /^(.*?) registers a patient from (.*) to (.*)$/ do |arg1, arg2, arg3|
  pending # express the regexp above with the code you wish you had
end

# table of registered patients

Then /^I should see patient "(.*?)" with time "(.*?)" and status "(.*?)"$/ do |patient_name, time, status|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the following patients: (.*)$/ do |patients_list|
  patients_list = patients_list.split(/,/)
  patients_list.each do |patient_name|
    puts assert_match(/#{patient_name}/m, page.body)
  end
end

Then /^I should not see the following patients: (.*)$/ do |patients_list|
  patients_list = patients_list.split(/,/)
  patients_list.each do |patient_name|
    assert page.has_no_content?(patient_name)
  end
end

When /^I click SEE MORE$/ do
  click_link("see_more")
end

Then /^I should see a no registrations notification$/ do
  assert_match("there are no registrations to show", page.body)
end

Then /^I should see "(.*?)" before the "(.*?)" header$/ do |arg1, arg2|
  if arg2 != "yesterday"
    header = Chronic::parse(arg2)
  else
    header = "YESTERDAY"
  end
  assert_match(/#{arg1}(.*)#{header}/m, page.body)
end

Then /^I should see the "(.*?)" header before "(.*?)"$/ do |arg1, arg2|
  if arg1 != "yesterday"
    header = Chronic::parse(arg1)
  else
    header = "YESTERDAY"
  end
  assert_match(/#{header}(.*)#{arg2}/m, page.body)
end

Then /^I should list "(.*?)" before "(.*?)"$/ do |arg1, arg2|
  assert_match(/#{arg1}(.*)#{arg2}/m, page.body)
end

