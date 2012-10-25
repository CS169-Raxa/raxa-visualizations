class DrugsController < ApplicationController
  def update
    id = params[:id]
    drug = Drug.find(id)

    drug_params = params[:drug]
    drug.user_rate = drug_params[:user_rate]
    drug.alert_level = drug_params[:alert_level]
    drug.save!

    success_message = %Q[#{drug.name} successfully saved]
    if request.xhr?
      render :partial => 'pharmacy/notice', :locals => { :notice => success_message }
    else
      flash[:notice] = success_message
      redirect_to pharmacy_path
    end
  end
end

