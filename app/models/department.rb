class Department < ActiveRecord::Base
  attr_accessible :name
  has_many :encounters

  def get_quartiles(start_time, end_time)
    encounters = self.encounters.has_ended.where(
      'start_time >= :start_time and start_time <= :end_time',
      { :start_time => start_time, :end_time => end_time }
    )

    times = encounters.map { |e| e.elapsed_time}

    if times.length > 0
      return {
        :min => times.min,
        :first => times.percentile(25),
        :median => times.median,
        :third => times.percentile(75),
        :max => times.max
      }
    else
      return nil
    end
  end
end
