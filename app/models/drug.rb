class Drug < ActiveRecord::Base
  has_many :drug_deltas
  attr_accessible :alert_level, :estimated_rate, :name, :quantity, :user_rate

  def time_left
    if user_rate
      quantity/user_rate
    elsif estimated_rate
      quantity/estimated_rate
    end
  end
end
