class Room < ActiveRecord::Base
  attr_accessible :name
  has_many :messages
  validates :name, :presence => true
  validates_uniqueness_of :name
end
