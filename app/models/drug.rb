class Drug < ActiveRecord::Base
  has_many :drug_deltas
  attr_accessible :alert_level, :estimated_rate, :name, :user_rate, :units, :quantity

  def alert?
    if self.alert_level and self.quantity and self.quantity <= self.alert_level
      true
    elsif self.time_left and self.time_left < 1.week
      true
    else
      false
    end
  end

  def recent_deltas time_period
    drug_deltas.where('timestamp >= :time', {:time => Time.now - time_period})
  end

  # Compute historical stock levels for the period of time specified by looking
  # up corresponding drug deltas
  #
  # eg. For the last 24 hours of drug stock levels,
  #     `Drug.first.history 60*60*24`
  def history time_period
    history = []
    current_quantity = quantity
    history << {
      :date => Time.now.to_i,
      :count => current_quantity
    }
    recent_deltas = recent_deltas(time_period).order('timestamp DESC')
    recent_deltas.each do |delta|
      current_quantity -= delta.amount
      history << {
        :date => delta.timestamp.to_i,
        :count => current_quantity
      }
    end
    return recent_deltas.empty? ? false : history
  end

  def time_aggregated_data time_period, group_by_period
    quantities = history time_period
    return false if not quantities

    output = []
    quantities.group_by do |hash|
      (hash[:date] / group_by_period).to_i * group_by_period
    end.each_entry do |date, date_qty_groups|
      qtys = date_qty_groups.map {|dqg| dqg[:count]}
      output << {
        :date => date,
        :count => (qtys.inject(:+) / qtys.size)
      }
    end
    output
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
