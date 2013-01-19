class DaysController < ApplicationController
  def index
    offset = params[:offset].to_i
    days = []

    date = ([Checkin.first.created_at, Time.now.utc].max - offset.minutes).to_date

    7.times do
      day = {
        date: date,
        checkin_count: Checkin.for_date(date, offset).count,
      }
      days.push day
      date = date - 1.day
    end

    render json: days
  end

  def show
    date = Date.parse(params[:date])

    day = {
      date: date,
      checkins: ActiveModel::ArraySerializer.new(Checkin.for_date(date))
    }

    render json: day
  end
end
