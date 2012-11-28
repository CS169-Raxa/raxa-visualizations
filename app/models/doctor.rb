class Doctor < ActiveRecord::Base
  attr_accessible :max_workload, :name
  validates :name, :presence => true

  has_many :patients
  has_and_belongs_to_many :specialties

  def num_patients
    return self.patients.size
  end
end
