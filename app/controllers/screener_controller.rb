class ScreenerController < ApplicationController
  def index
    @sorted_doctors = Doctor.sorted_by_workload
    @patients_left = 7
    @specialties = Specialty.all
  end
end
