class Registration < ActiveRecord::Base
  attr_accessible :patient_status, :time_end, :time_start
  validates :patient_status, :inclusion => {:in => ['new', 'returning']}
  belongs_to :patient
  belongs_to :registrar
  scope :since, lambda { |time| where("time_end > ?", time) }
end
