class PharmacyController < ApplicationController
  # see how long drug will last based on previous usage rates
  def index
    @drugs = Drug.find(:all)
    @drug_array = []
    @drugs.each do |drug|
      if drug[:user_rate] 
        time_left = drug[:quantity]/drug[:user_rate]
      elsif drug[:estimated_rate] 
        time_left = drug[:quantity]/drug[:estimated_rate]
      end
      @drug_array << {
        :drug => drug,
        :time_left => time_left
      }
    end
  end
end
