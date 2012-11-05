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

  def registration_history(start_date, end_date)
    history = []
    start_date.upto(end_date) do |day|
      history << {
        :date => day,
        :count => self.registrations.where(
          "time_start >= :start_date and time_start <= :end_date",
          :start_date => day,
          :end_date => day + 1.day
        ).count
      }
    end
    return history
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
