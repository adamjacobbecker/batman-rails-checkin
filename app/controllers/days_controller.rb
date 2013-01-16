class DaysController < ApplicationController
  def index
    days = []

    date = Date.current

    7.times do
      day = {date: date, checkin_count: Checkin.for_date(date).count, date_pretty: prettify_date(date)}
      days.push day
      date = date - 1.day
    end

    render json: days
  end

  def show
    date = params[:date]

    date = Date.current if date == "today"

    day = {
      date: date,
      date_pretty: prettify_date(date),
      checkins: ActiveModel::ArraySerializer.new(Checkin.for_date(date))
    }

    render json: day
  end

  private

  def prettify_date(date)
    if date == Date.current
      "Today"
    elsif date == Date.yesterday
      "Yesterday"
    else
      date.to_time.strftime("%-m/%-d/%y")
    end
  end
end
