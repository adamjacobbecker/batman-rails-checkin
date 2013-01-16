class DaysController < ApplicationController
  def index
    days = []

    date = Date.current

    7.times do
      day = {
        date: date,
        checkin_count: Checkin.for_date(date).count,
        date_pretty: prettify_date(date),
        date_slashes: prettify_date(date, true)
      }
      days.push day
      date = date - 1.day
    end

    render json: days
  end

  def show
    if params[:date] == "today"
      date = Date.current
    else
      date = Date.parse(params[:date])
    end

    day = {
      date: date,
      date_pretty: prettify_date(date),
      date_slashes: prettify_date(date, true),
      checkins: ActiveModel::ArraySerializer.new(Checkin.for_date(date))
    }

    render json: day
  end

  private

  def prettify_date(date, force_slashes = false)
    if !force_slashes && date == Date.current
      "Today"
    elsif !force_slashes && date == Date.yesterday
      "Yesterday"
    else
      date.to_time.strftime("%-m/%-d/%y")
    end
  end
end
