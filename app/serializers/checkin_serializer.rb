class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :body, :date, :user_id

  def date
    object.created_at.strftime("%m/%d/%Y")
  end
end
