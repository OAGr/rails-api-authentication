class Message < ActiveRecord::Base
  attr_accessible :name, :room_id
  belongs_to :room
  validates :name, :presence => true
  validates_uniqueness_of :name
end
