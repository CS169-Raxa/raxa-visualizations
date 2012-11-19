class SuperuserController < ApplicationController
  def index
    @departments = Department.all
  end
end
