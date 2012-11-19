class SuperuserController < ApplicationController
  def index
    @departments = Department.all
  end

  def timelines
    encounters = Encounter.includes(:department).includes(:patient).
      where('patient_id IN (SELECT id FROM patients WHERE id IN ' \
      '(SELECT patient_id FROM encounters WHERE ' \
      'encounters.end_time IS NULL OR encounters.end_time >= ? ))',
      12.hours.ago).order('end_time ASC').to_a

    result = []
    encounters.group_by(&:patient_id).map do |patient_id, encounters|
      result << {
        :name => encounters.first.patient.name,
        :stages => encounters.map do |e|
          {
            :name => e.department.name,
            :start => e.start_time,
            :end => e.end_time
          }
        end
      }
    end

    render :json => result
  end
end
