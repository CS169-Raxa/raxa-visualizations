class Department < ActiveRecord::Base
  attr_accessible :name
  has_many :encounters

  def get_quartiles(start_time, end_time)
    encounters = self.encounters.has_ended.where(
      'start_time >= :start_time and start_time <= :end_time',
      { :start_time => start_time, :end_time => end_time }
    )

    stats = DescriptiveStatistics.new(encounters.map { |e| e.elapsed_time})

    if stats.length > 0
      return {
        :min => stats.min,
        :first => stats.value_from_percentile(25),
        :median => stats.median,
        :third => stats.value_from_percentile(75),
        :max => stats.max
      }
    else
      return nil
    end
  end

  def average_time
    encounters = self.encounters.has_ended
    return 0 if encounters.length == 0
    total_time = encounters.map {|e| e.elapsed_time}.reduce(:+)
    ChronicDuration.output((total_time/encounters.length).to_i, :format => :chrono)
  end
end
