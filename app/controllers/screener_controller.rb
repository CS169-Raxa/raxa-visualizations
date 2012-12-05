class ScreenerController < ApplicationController
  def index
    if params[:specialty]
      @specialty = Specialty.find(params[:specialty])
      doctors = Doctor.has_specialty(@specialty)
      @filtering = true
    else
      doctors = Doctor.all
      @filtering = false
    end
    @sorted_doctors = doctors.sort{|doc| doc.workload}
    @patients_left = 7
    @specialties = Specialty.all
    render :index
  end
end
