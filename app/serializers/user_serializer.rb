class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :login, :gravatar_url, :project_id

  def project_id
    @options[:project_id]
  end

  def include_project_id?
    @options[:project_id]
  end
end
