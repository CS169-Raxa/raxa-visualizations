class Encounter < ActiveRecord::Base
  attr_accessible :start_time, :end_time
  validates :start_time, :presence => true

  belongs_to :department
  belongs_to :patient

  scope :has_ended, lambda {
    where('end_time IS NOT NULL')
  }

  def elapsed_time
    (self.end_time or Chronic::now) - self.start_time
  end
end
