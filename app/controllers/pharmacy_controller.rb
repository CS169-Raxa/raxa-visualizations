class PharmacyController < ApplicationController
  # see how long drug will last based on previous usage rates
  def index
    has_history, no_history = Drug.all.partition{|drug| drug.time_left != false}
    has_history.sort_by! do |drug|
      [drug.alert? ? 0 : 1, drug.time_left]
    end
    @drugs = no_history + has_history
  end
end
