class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :project_id, :body, :body_html, :date, :created_at

  def body_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(object.body)
  end
end
