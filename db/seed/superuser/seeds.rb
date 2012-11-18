require 'find'

data_path = Rails.root.join('db', 'seed', 'superuser', 'data')

Dir.glob(data_path.join('*.yaml')) do |path|
  patient_data, encounters_data = YAML.load_stream(File.open(path))
  patient = Patient.create(patient_data)
  encounters_data.each do |ed| 
    ed['timestamp'] = Chronic::parse(ed['timestamp'])
    encounter = Encounter.create(ed)
    patient.encounters << encounter
  end
  patient.save
end

