class Registration < ActiveRecord::Base
  attr_accessible :patient_status, :time_end, :time_start
  validates :patient_status, :inclusion => {:in => ['new', 'returning']}
  belongs_to :patient
  belongs_to :registrar
  scope :for_day, lambda { |time|
    day = time.beginning_of_day
    where("time_end >= ? AND time_end < ?", day, day + 1.day)
  }

  def elapsed_time
    ChronicDuration.output((self.time_end - self.time_start).to_i, :format => :chrono)
    self.time_end - self.time_start
  end
end
