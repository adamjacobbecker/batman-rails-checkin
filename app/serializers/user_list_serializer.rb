class UserListSerializer < UserSerializer
  has_one :latest_checkin

  def latest_checkin
    object.latest_checkin_for_project_id(@options[:project_id])
  end
end
