class Registrar < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :registrations

  def registrations_for_day(day)
    registrations.for_day day
  end

  def average_time
    total_time = self.registrations.map {|r| r.elapsed_time}.reduce(:+)
    ChronicDuration.output((total_time/self.registrations.length).to_i, :format => :chrono)
  end
end
