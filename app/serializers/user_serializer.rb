class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :gravatar_url
end
