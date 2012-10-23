class DrugsController < ApplicationController
  def update
    id = params[:id]
    drug = Drug.find(id)

    drug_params = params[:drug]
    drug.user_rate = drug_params[:user_rate]
    drug.alert_level = drug_params[:alert_level]
    drug.save!

    redirect_to pharmacy_path
  end
end

