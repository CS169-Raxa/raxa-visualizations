class DrugsController < ApplicationController
  def update
    puts params
    id = params[:id]
    drug = Drug.find(id)
    override = params[:override]
    alert_level = params[:drug][:alert_level]
    if override
      drug.user_rate = override
    end
    if alert_level
      drug.alert_level = alert_level
    end
    drug.save!
  end
end

