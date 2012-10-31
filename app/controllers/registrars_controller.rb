class RegistrarsController < ApplicationController
  def index
    @num_today = Registration.since(Date.today).count
    render :show
  end
  def show
    @registrar = Registrar.find(params[:id])
    @num_today = @registrar.registrations.since(Date.today).count
  end
end
