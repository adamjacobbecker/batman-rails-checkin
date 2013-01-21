class UserDetailsSerializer < UserSerializer
  has_many :checkins

  def checkins
    object.checkins.where(project_id: @options[:project_id])
  end
end
