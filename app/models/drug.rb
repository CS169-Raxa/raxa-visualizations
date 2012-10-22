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

end
