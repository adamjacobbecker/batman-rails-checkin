class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :body, :body_html, :date, :date_slashes, :date_pretty, :time_pretty, :user_id

  def date_slashes
    date_pretty(true)
  end

  def date_pretty(force_slashes = false)
    date = Date.parse(object.date)

    if !force_slashes && date == Date.current
      "Today"
    elsif !force_slashes && date == Date.yesterday
      "Yesterday"
    else
      date.to_time.strftime("%-m/%-d/%y")
    end
  end

  def time_pretty
    object.created_at.strftime("%-H:%M%P")
  end

  def body_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(object.body)
  end
end
