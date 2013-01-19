class DaysController < ApplicationController
  before_filter :project_exists

  def index
    offset = params[:offset].to_i
    days = []

    date = ([@project.checkins.first.created_at, Time.now.utc].max - offset.minutes).to_date

    7.times do
      day = {
        project_id: @project.id,
        date: date,
        checkin_count: Checkin.for_date(date, offset).where(project_id: @project.id).count,
      }
      days.push day
      date = date - 1.day
    end

    render json: days
  end

  def show
    date = Date.parse(params[:date])

    day = {
      project_id: @project.id,
      date: date,
      checkins: ActiveModel::ArraySerializer.new(Checkin.for_date(date).where(project_id: @project.id))
    }

    render json: day
  end

  def project_exists
    @project = Project.find params[:project_id]
  end
end
