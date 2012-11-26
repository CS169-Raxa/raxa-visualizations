class Doctor < ActiveRecord::Base
  attr_accessible :max_workload, :name, :specialty
  validates :name, :presence => true

  has_many :patients

  def num_patients
    return self.patients.size
  end
end
