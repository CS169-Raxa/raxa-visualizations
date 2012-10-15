class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
    flash[:notice] = 'Coming soon..'
    redirect_to root_path
  end
end
