class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.for_day(Date.today).count
    render :show
  end
  def show
    @registrar = Registrar.find(params[:id])
    @num_today = @registrar.registrations.for_day(Date.today).count
  end
end
