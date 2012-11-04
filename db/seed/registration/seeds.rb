require 'find'

data_path = Rails.root.join('db', 'seed', 'registration', 'data')

Dir.glob(data_path.join('*.yaml')) do |path|
  registrar_data, registrations_data = YAML.load_stream(File.open(path))
  registrar = Registrar.create(registrar_data)
  registrations_data.each do |rd|
    patient = Patient.create(:name => rd['patient_name'])
    registration_data = rd['registration_data']
    registration_data['time_start'] = Chronic::parse(registration_data['time_start'])
    registration_data['time_end'] = Chronic::parse(registration_data['time_end'])
    registration = Registration.create(registration_data)
    patient.registrations << registration
    registrar.registrations << registration
  end
  registrar.save
end

