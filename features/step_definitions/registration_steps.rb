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
    visit "/registration/registrars/#{registrar.id}"
  end
end

# num patients registered
When /^(.*?) registers a patient$/ do |registrar_name|
  registrar = Registrar.find_by_name(registrar_name)
  registrar.registrations.create!(:time_start => Time.now - 5.minutes,
                                  :time_end => Time.now)
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

Then /^I should see a graph of (\d+) patients$/ do |num|
  pending
end

Then /^I should see a missing patients notification$/ do 
  page.should have_content("No Registrations")
end
