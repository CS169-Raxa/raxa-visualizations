class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.for_day(Time.now).count
    @average_time = average_time(Registration.all)
    render :show
    @registration_history = Hash.new {|hash, key| 0}
    Registrar.all.each do |registrar|
      registrar.registration_history(Date.today - 1.week, Date.today).each do |date, count|
        @registration_history[date] += count
      end
    end
  end

  def show
    registrar = Registrar.find(params[:id])
    @num_today = registrar.registrations_for_day(Time.now).count
    @average_time = average_time(registrar.registrations)
    @registration_history = registrar.registration_history(Date.today - 1.week, Date.today)
  end

  protected
  def average_time(registrations)
    total_time = registrations.map {|r| r.elapsed_time}.reduce(:+)
    return ChronicDuration.output((total_time/registrations.length).to_i, :format => :chrono)
  end
end
