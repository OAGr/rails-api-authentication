class Room < ActiveRecord::Base
  attr_accessible :name
  has_many :messages
  belongs_to :user
  validates :name, :presence => true
  validates_uniqueness_of :name
end
