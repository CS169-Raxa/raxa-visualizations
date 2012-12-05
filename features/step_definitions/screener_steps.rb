# Screener module

Given /^the following doctors exist:$/ do |table|
  table.hashes.each do |doctor|
    d = Doctor.create!(
      :name => doctor['name'],
      :max_workload => doctor['max_workload']
    )
    d.specialties << doctor['specialty']
      .split(/,\s+/)
      .uniq
      .map {|s| Specialty.find_by_name(s) || Specialty.create(:name => s)}

    doctor['number of patients'].to_i.times do
      d.patients << Patient.create
    end
  end
end

When /^I am on the screener dashboard$/ do
  visit('/screener')
end

When /^I filter by "(.*)"/ do |filter|
  if filter == 'All'
    step 'I am on the screener dashboard'
  else
    page.select(filter, :from => 'department_select')
    click_button 'filter_submit'
  end
end

When /^I should (not )?see the following doctors: (.*)/ do |negate, doctors|
  doctors.split(/,\s+/).each do |doctor|
    query = have_css '.doctor_name', :text => doctor
    if negate
      page.should_not query
    else
      page.should query
    end
  end
end
