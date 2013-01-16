class CheckinListSerializer < ActiveModel::Serializer
  attributes :id, :body, :date

  has_one :user

  def date
    object.created_at.strftime("%m/%d/%Y")
  end
end
