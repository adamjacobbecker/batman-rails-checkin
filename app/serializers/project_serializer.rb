class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :owner_id, :campfire_subdomain, :campfire_token, :campfire_room, :hipchat_token, :hipchat_room
end
