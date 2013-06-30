class Project < ActiveRecord::Base
  attr_accessible :name, :campfire_subdomain, :campfire_token, :campfire_room, :hipchat_token, :hipchat_room

  belongs_to :owner, class_name: "User"

  has_many :checkins
  has_many :invitees
  has_and_belongs_to_many :users, uniq: true
end
