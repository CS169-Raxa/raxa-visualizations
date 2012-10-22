require 'find'

data_path = Rails.root.join('db', 'seed', 'pharmacy', 'data')

Dir.glob(data_path.join('*.yaml')) do |path|
  drug_data, delta_data = YAML.load_stream(File.open(path))
  drug = Drug.create(drug_data)
  delta_data.each do |dd|
    dd['timestamp'] = Chronic::parse(dd['timestamp'])
    delta = DrugDelta.create(dd)
    drug.drug_deltas << delta
  end
  drug.save
end
