class SuperuserController < ApplicationController
  def index
    @encounters = Encounter.all
  end
end
