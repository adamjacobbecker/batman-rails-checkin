class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :remember_token
end
