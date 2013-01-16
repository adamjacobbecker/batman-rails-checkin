class UserListSerializer < ActiveModel::Serializer
  attributes :id, :email, :gravatar_url

  has_one :latest_checkin
end
