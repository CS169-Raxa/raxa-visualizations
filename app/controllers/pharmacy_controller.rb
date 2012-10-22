class PharmacyController < ApplicationController
  def index
    @drugs = Drug.all
  end
end
