class Doctor < ActiveRecord::Base
  attr_accessible :max_workload, :name
  validates :name, :presence => true

  has_many :patients
  has_and_belongs_to_many :specialties

  def self.sorted_by_workload
    all.sort{|doctor| doctor.workload}
  end

  def num_patients
    return self.patients.size
  end

  def specialty_names
    self.specialties.map{|specialty| specialty.name}
  end

  def workload
    # if the load is greater than 100, limit to 100
    [(100 * num_patients.to_f / max_workload).to_i, 100].min
  end
end
