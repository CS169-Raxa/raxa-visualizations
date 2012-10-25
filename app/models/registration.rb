class Registration < ActiveRecord::Base
  attr_accessible :patient_status, :time_end, :time_start
end
