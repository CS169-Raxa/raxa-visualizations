require 'find'

data_path = Rails.root.join('db', 'seed', 'superuser', 'data')

Dir.glob(data_path.join('*.yaml')) do |path|
  patient_data, encounters_data = YAML.load_stream(File.open(path))
  patient = Patient.create(patient_data)
  encounters_data.each do |ed| 
    start_time = Chronic::parse(ed['start_time'])
    end_time = Chronic::parse(ed['end_time'])

    department = Department.find_by_name(ed['department']) ||
      Department.create(:name => ed['department'])

    encounter = Encounter.create(
      :start_time => start_time,
      :end_time => end_time
    )

    department.encounters << encounter
    patient.encounters << encounter
  end
  patient.save
end

