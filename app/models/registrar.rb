class Registrar < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :registrations
  def registrations_for_day(day)
    registrations.for_day day
  end
end
