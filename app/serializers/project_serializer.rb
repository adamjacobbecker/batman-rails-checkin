class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :owner_id, :campfire_subdomain, :campfire_token, :campfire_room
end
