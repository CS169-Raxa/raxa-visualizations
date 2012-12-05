require 'find'

data_path = Rails.root.join('db', 'seed', 'screener', 'data')

Dir.glob(data_path.join('*.yaml')) do |path|
  doctor_data, patients_data = YAML.load_stream(File.open(path))

  specialties = []
  doctor_data.each do |dd|
    dd['specialties'].each do |sp|
      specialties << Specialty.find_or_create_by_name(sp)
    end
    dd.delete 'specialties'

    d = Doctor.create(dd)
    specialties.each { |sp| d.specialties << sp }

    patients_data.each do |patient|
      d.patients << Patient.find_or_create_by_name(patient['patient_name'])
    end

    d.save!
  end
end
