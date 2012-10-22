class Drug < ActiveRecord::Base
  has_many :drug_deltas
  attr_accessible :alert_level, :estimated_rate, :name, :user_rate, :units, :quantity, :low_stock_point

  def quantity=(q)
    self[:quantity] = q
    lsp = self[:low_stock_point]
    if lsp == nil
      return
    end
    if self[:quantity] <= lsp
      self[:alert_level] = 1
    elsif self[:quantity] > lsp
      write_attribute(:alert_level, 0)
    end

  end

  def low_stock_point=(lsp)
    self[:low_stock_point] = lsp
    q = self[:quantity]
    if q == nil
      return
    end
    if q <= self[:low_stock_point]
      self[:alert_level] = 1
    elsif q > self[:low_stock_point]
      self[:alert_level] = 0
    end
  end

  def recent_deltas time_period
    drug_deltas.where('timestamp >= :time', {:time => Time.now - time_period})
  end

  # Compute historical stock levels for the period of time specified by looking
  # up corresponding drug deltas
  def history time_period
    current_quantity = quantity
    quantities = [[Time.now.to_i, current_quantity]]
    recent_deltas = recent_deltas(time_period).order('timestamp DESC')
    recent_deltas.each do |delta|
      current_quantity -= delta.amount
      quantities << [delta.timestamp.to_i, current_quantity]
    end
    recent_deltas.empty? ? false : quantities
  end

  # Based on total consumption of the previous week
  def estimated_rate
    recent_deltas(1.week).consumed.sum(:amount).abs/1.week
  end

  def user_rate_per_second
    user_rate/1.week
  end

  def time_left
    if user_rate and user_rate > 0
      quantity/user_rate_per_second
    elsif estimated_rate and estimated_rate > 0
      quantity/estimated_rate
    else
      false
    end
  end
end
