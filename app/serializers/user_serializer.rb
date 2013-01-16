class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :gravatar_url
end
