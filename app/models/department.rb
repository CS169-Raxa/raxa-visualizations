class Department < ActiveRecord::Base
  attr_accessible :name
  has_many :encounters

  def get_quartiles(start_time, end_time)
    encounters = self.encounters.has_ended.where(
      'start_time >= :start_time and start_time <= :end_time',
      { :start_time => start_time, :end_time => end_time }
    )

    times = encounters.map { |e| e.elapsed_time}.sort
    return {
      :min => times[0],
      :first => times[times.length/4],
      :median => times[times.length/2],
      :third => times[3 * times.length/4],
      :max => times[-1]
    }
  end
end
