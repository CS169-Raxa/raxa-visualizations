class DrugsController < ApplicationController
  def update
    id = params[:id]
    drug = Drug.find(id)

    drug.user_rate = params[:user_rate]
    drug.alert_level = params[:alert_level]
    drug.save!

    redirect_to pharmacy_path
  end
end

