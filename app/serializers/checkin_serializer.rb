class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :body, :date, :user_id
end
