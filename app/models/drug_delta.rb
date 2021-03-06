class DrugDelta < ActiveRecord::Base
  belongs_to :drug
  attr_accessible :amount, :description, :timestamp

  scope :consumed, where('amount < 0')
end
