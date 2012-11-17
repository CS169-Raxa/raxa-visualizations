class DepartmentsController < ApplicationController
  def show
    @department = Department.find(params[:id])
    @department_history = []
    6.downto(0).each do |x|
      datum = {}
      start_time = Time.now.beginning_of_day - x.days
      end_time = Time.now.beginning_of_day - (x-1).days
      datum['date'] = start_time
      datum['data'] = @department.get_quartiles(start_time, end_time)
      @department_history << datum
    end
    @average_time = @department.average_time
  end
end
