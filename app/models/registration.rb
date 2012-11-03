class Registration < ActiveRecord::Base
  attr_accessible :patient_status, :time_end, :time_start, :patient_name, :registrar_name
  validates :patient_status, :inclusion => {:in => ['new', 'returning']}
  belongs_to :patient
  belongs_to :registrar

  def patient_name= (name)
      self.patient = Patient.find_by_name(name)
      @patient_name = name
  end

  def registrar_name= (name)
      self.registrar = Registrar.find_by_name(name)
      @registrar_name = name
  end

  scope :for_day, lambda { |time|
    day = time.beginning_of_day
    where("time_end >= ? AND time_end < ?", day, day + 1.day)
  }

  def elapsed_time
    self.time_end - self.time_start
  end
end
