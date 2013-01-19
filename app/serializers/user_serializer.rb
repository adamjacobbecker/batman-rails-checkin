class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :login, :gravatar_url
end
