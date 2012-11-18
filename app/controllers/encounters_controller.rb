class EncountersController < ApplicationController
  def index
    @reg_encounters = Encounter.history("Registration", Date.today - 1.week, Date.today)
    @pharm_encounters = Encounter.history("Pharmacy", Date.today - 1.week, Date.today)
    @screen_encounters = Encounter.history("Screening", Date.today - 1.week, Date.today)

    @reg_time = average_time(reg_encounters)
    @pharm_time = average_time(pharm_encounters)
    @screen_time = average_time(screen_encounters)
  end

  def average_time(encounters)
    total_time = encounters.map {|e| e.elapsed_time}.reduce(:+)
    if total_time
      return ChronicDuration.output((total_time/registrations.length).to_i, :format => :chrono) 
    else
      return 0 
    end
  end
end
