class Doctor < ActiveRecord::Base
  attr_accessible :max_workload, :name
  validates :name, :presence => true

  has_many :patients
  has_and_belongs_to_many :specialties

  scope :sorted_by_num_patients, (lambda do
    select("#{Doctor.table_name}.*, COUNT(#{Patient.table_name}.id) num_pats")
      .joins(Patient.table_name.to_sym)
      .order(:num_pats)
  end)

  def num_patients
    return self.patients.size
  end

  def specialty_names
    self.specialties.map{|specialty| specialty.name}
  end
end
