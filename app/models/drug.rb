class Drug < ActiveRecord::Base
  has_many :drug_deltas
  attr_accessible :alert_level, :estimated_rate, :name, :quantity, :user_rate
end
