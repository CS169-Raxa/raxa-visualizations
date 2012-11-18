class Encounter < ActiveRecord::Base
  attr_accessible :department, :time_start
  validates :stage, :inclusion => {:in => ['Registration', 'Pharmacy', 'Screening']}
  belongs_to :patient
end
