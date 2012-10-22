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
    quantities = [[Time.now, current_quantity]]
    recent_deltas(time_period).order('timestamp DESC').each do |delta|
      current_quantity -= delta.amount
      quantities << [delta.timestamp, current_quantity]
    end
    quantities
  end
end
