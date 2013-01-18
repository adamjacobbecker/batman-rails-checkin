class DaysController < ApplicationController
  def index
    days = []

    date = [Checkin.first.created_at.to_date, Time.at(params[:now].to_i).to_date].max

    7.times do
      day = {
        date: date,
        checkin_count: Checkin.for_date(date).count,
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
