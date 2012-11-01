require 'find'

data_path = Rails.root.join('db', 'seed', 'registration', 'data')

Dir.glob(data_path.join('*.yaml')) do |path|
  registrar_data, registrations_data = YAML.load_stream(File.open(path))
  registrar = Registrar.create(registrar_data)
  registrations_data.each do |rd|
    rd['time_start'] = Chronic::parse(rd['time_start'])
    rd['time_end'] = Chronic::parse(rd['time_end'])
    registration = Registration.create(rd)
    registrar.registrations << registration
  end
  registrar.save
end

