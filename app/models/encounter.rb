class Encounter < ActiveRecord::Base
  attr_accessible :department, :start_time, :end_time
  validates :start_time, :presence => true

  belongs_to :patient

  scope :has_ended, lambda {
    where(:conditions => 'end_time IS NOT NULL')
  }

  def elapsed_time
    (self.time_end or Chronic::now) - self.time_start
  end

  def self.get_quartiles(start_time, end_time)
    encounters_by_department = Encounters.has_ended.where(
      'start_time >= :start_time and start_time <= :end_time',
      { :start_time => start_time, :end_time => end_time }
    ).group_by { |e| e.department }

    quartiles = {}
    encounters_by_department.each do |department, encounters|
      times = encounters.map { |e| e.elapsed_time}.sort
      quartiles[department] = {
        :min => times[0],
        :first => times[times.length/4],
        :median => times[times.length/2],
        :third => times[3 * times.length/4],
        :max => times[-1]
      }
    end
    return quartiles
  end
end
