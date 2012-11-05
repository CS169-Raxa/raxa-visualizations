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
    patient.registrations << registration  end
end

When /^I click the link "(.*?)"$/ do |arg1|
  click_link(arg1)
end


# paths
Given /^I am on the (.*?) registration dashboard$/ do |registrar_name|
  if registrar_name == 'overall'
    visit '/registration/registrars'
  else
    registrar = Registrar.find_by_name(registrar_name)
    visit(registration_registrar_path(registrar.id))
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
Then /^I should see that the average time to register a patient is (\d+) minutes$/ do |minutes|
  find('#average-time').text.should include "#{minutes}:00"
end

When /^(.*?) registers a (new|returning) patient from (.*) to (.*)$/ do |name, status, start_time, end_time|
  registrar = Registrar.find_by_name(name)
  registration = Registration.create!(
    :patient_status => status,
    :time_start => Chronic::parse(start_time),
    :time_end => Chronic::parse(end_time)
  )
  registrar.registrations << registration
end

# table of registered patients

Then /^I should see patient "(.*?)" with time "(.*?)" and status "(.*?)"$/ do |patient_name, time, status|
  html_string = "<tr>\n<td> #{time}</td>\n<td>#{patient_name}</td>\n<td>#{status}</td>\n"
  assert_match(html_string, page.body)
end

Then /^I should see the following patients: (.*)$/ do |patients_list|
  patients_list = patients_list.split(/,/)
  patients_list.each do |patient_name|
    assert_match(/#{patient_name}/m, page.body)
  end
end

Then /^I should not see the following patients: (.*)$/ do |patients_list|
  patients_list = patients_list.split(/,/)
  patients_list.each do |patient_name|
    assert_no_match(/#{patient_name}/m, page.body)
  end
end

Then /^I should see a no registrations notification$/ do
  assert_match("there are no registrations to show", page.body)
end

Then /^I should see "(.*?)" before the "(.*?)" header$/ do |arg1, arg2|
  if arg2 != "yesterday"
    header = Chronic::parse(arg2).strftime('%^B %e, %Y')
  else
    header = "YESTERDAY"
  end
  assert_match(/#{arg1}(.*)#{header}/m, page.body)
end

Then /^I should see the "(.*?)" header before "(.*?)"$/ do |arg1, arg2|
  if arg1 != "yesterday"
    header = Chronic::parse(arg1).strftime('%^B %e, %Y')
  else
    header = "YESTERDAY"
  end
  assert_match(/#{header}(.*)#{arg2}/m, page.body)
end

Then /^I should list "(.*?)" before "(.*?)"$/ do |arg1, arg2|
  assert_match(/#{arg1}(.*)#{arg2}/m, page.body)
end

