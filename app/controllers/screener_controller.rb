class ScreenerController < ApplicationController
  def index
    if params[:specialty]
      @specialty = Specialty.find_by_id(params[:specialty])
      if @specialty.nil?
        flash[:notice] = "Invalid specialty!"
        redirect_to screener_path
        return
      end
      doctors = Doctor.has_specialty(@specialty)
      @filtering = true
    else
      doctors = Doctor.all
      @filtering = false
    end
    @sorted_doctors = doctors.sort_by{|doc| doc.workload}
    @patients_left = 7
    @specialties = Specialty.all
    render :index
  end
end
