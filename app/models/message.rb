class Message < ActiveRecord::Base
  attr_accessible :name, :room_id
  belongs_to :room
end
