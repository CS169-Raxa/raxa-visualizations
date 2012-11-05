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

  def registration_history time_period
    registrations.where("time_start >= :time", {:time => Time.now - time_period})
    quantities = []
    registrations.each do |reg|
      quantities << [reg.time_start.to_i, 1] 
    end
    quantities
  end

  def time_aggregated_registrations time_period, group_by_period
    registrations = registration_history time_period
    return false if not registrations
  
    output = []
    registrations.group_by do |time, qty|
      time / group_by_period * group_by_period
    end.each_entry do |date, date_qty_groups|
      qtys = date_qty_groups.map {|dqg| dqg[1]}
      output << [date, qtys.size]
    end
    output
  end
end
