class Drug < ActiveRecord::Base
  has_many :drug_deltas
  attr_accessible :alert_level, :estimated_rate, :name, :quantity, :user_rate

  def recent_deltas time_period
    drug_deltas.where('timestamp >= :time', {:time => Time.now - time_period})
  end

  # Compute historical stock levels for the period of time specified by looking
  # up corresponding drug deltas
  def history time_period
    current_quantity = quantity
    quantities = [[Time.now, current_quantity]]
    recent_deltas(time_period).order('timestamp DESC').each do |delta|
      current_quantity -= delta.amount
      quantities << [delta.timestamp, current_quantity]
    end
    quantities
  end

  # Total consumption of the previous week
  def estimated_rate
    recent_deltas(1.week).consumed.sum(:amount).abs/1.week
  end

  def time_left
    if user_rate
      quantity/user_rate
    elsif estimated_rate
      quantity/estimated_rate
    end
  end
end
