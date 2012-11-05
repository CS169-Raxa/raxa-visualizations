class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.for_day(Time.now).count
    @average_time = average_time(Registration.all)
    render :show
  end

  def show
    @registrar = Registrar.find(params[:id])
    registrar = Registrar.find(params[:id])
    @num_today = registrar.registrations_for_day(Time.now).count
    @average_time = average_time(registrar.registrations)
  end

  protected
  def average_time(registrations)
    total_time = registrations.map {|r| r.elapsed_time}.reduce(:+)
    return ChronicDuration.output((total_time/registrations.length).to_i, :format => :chrono)
  end

  def time_graph
    registrar = Registrar.find(params[:id])
    @data = registrar.time_aggregated_registrations(params[:time_period].to_i,
                                      params[:group_by_period].to_i)

    respond_to do |format|
      format.json { render :json => { :data => @data, :registrar => @registrar } } 
    end
  end
end
