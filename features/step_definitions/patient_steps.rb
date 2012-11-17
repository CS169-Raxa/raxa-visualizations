Given /^the following patients exist:$/ do |table|
  table.hashes.each do |patient|
    Patient.create!(patient)
  end
end

Given /^Patients (.*?)\-(.*?) exist$/ do |let1, let2|
  (let1..let2).each do |letter|
    Patient.create!({:name => "Patient #{letter}"})
  end
end

Given /^Patient (.*?) has the following encounters:$/ do |letter, table|
  # table is a Cucumber::Ast::Table
  patient = Patient.find_by_name("Patient #{letter}")
  table.hashes.each do |encounter|

    department = Department.find_by_name(encounter[:department]) ||
      Department.create!({:name => encounter[:department]})
    encounter.delete(:department)

    if encounter[:end_time] == ""
       encounter[:end_time] = nil
    end

    e = Encounter.create!(encounter)

    department.encounters << e
    department.save!
    patient.encounters << e
    patient.save!
  end
end
