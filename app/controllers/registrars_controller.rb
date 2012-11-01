class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.for_day(Time.now).count
    render :show
  end
  def show
    @registrar = Registrar.find(params[:id])
    @num_today = @registrar.registrations_for_day(Time.now).count
  end
end
