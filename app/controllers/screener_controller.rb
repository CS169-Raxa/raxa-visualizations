class ScreenerController < ApplicationController
  def index
    @sorted_doctors = Doctor.sorted_by_num_patients
    @max_patients = [@sorted_doctors.last.patients.size, 1].max
    @patients_left = 7
    @specialties = Specialty.all
  end
end
