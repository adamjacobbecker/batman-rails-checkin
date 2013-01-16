class CheckinListSerializer < ActiveModel::Serializer
  attributes :id, :body, :date, :user_id

  has_one :user
end
