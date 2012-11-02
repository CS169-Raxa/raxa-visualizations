class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.for_day(Time.now).count
    @average_time = average_time(Registration.all)
    render :show
  end
  def show
    registrar = Registrar.find(params[:id])
    @num_today = registrar.registrations_for_day(Time.now).count
    @average_time = average_time(registrar.registrations)
  end

  protected
  def average_time(registrations)
    total_time = registrations.map {|r| r.elapsed_time}.reduce(:+)
    return ChronicDuration.output((total_time/registrations.length).to_i, :format => :chrono)
  end
end
