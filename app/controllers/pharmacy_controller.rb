class PharmacyController < ApplicationController
  # see how long drug will last based on previous usage rates
  def index
    @drugs = Drug.all
  end
end
