class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :body, :date

  def date
    object.created_at.strftime("%m/%d/%Y")
  end
end
