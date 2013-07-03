class Room < ActiveRecord::Base
  attr_accessible :name, :user_id
  has_many :messages
  belongs_to :user
  validates :name, :presence => true
  validates_uniqueness_of :name
end
