class Encounter < ActiveRecord::Base
  attr_accessible :department, :type, :timestamp
  validates :type, :inclusion => {:in => ['registration', 'pharmacy', 'screening']}
  belongs_to :patient

  def elapsed_time 
    if (self.time_end and self.time_start) 
      self.time_end - self.time_start
    end
  end

  def history(department, start_date, end_date) 
    history = []
    start_date.upto(end_date) do |day|
      history << {
        :date => date.to_time.to_i,
        :count =>self.where(
          "time_start >= :start_date and time_start <= :end_date",
          "department == :department", 
          :start_date => day,
          :end_date => day + 1.day
        ).count
      }
    end
  end    
end
