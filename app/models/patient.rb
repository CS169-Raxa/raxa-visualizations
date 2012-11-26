class Patient < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true

  has_many :registrations
  has_many :encounters
  belongs_to :doctor
end
