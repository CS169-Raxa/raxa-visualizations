class PharmacyController < ApplicationController
  # see how long drug will last based on previous usage rates
  def index
    @drugs = Drug.all.sort_by do |drug|
      [drug.time_left, drug.alert? ? 0 : 1]
    end
  end
end
