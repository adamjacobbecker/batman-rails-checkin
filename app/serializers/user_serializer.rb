class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :email, :name, :login, :gravatar_url, :project_id, :projects_users_id

  def user_id
    object.id
  end

  def project_id
    @options[:project_id]
  end

  def projects_users_id
    "#{object.id}_#{@options[:project_id]}"
  end

  def include_project_id?
    @options[:project_id]
  end

  def include_projects_users_id?
    @options[:project_id]
  end
end
