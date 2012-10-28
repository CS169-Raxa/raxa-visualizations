class RegistrationController < ApplicationController
  def index
    @registrars = Registrar.all
  end
end
