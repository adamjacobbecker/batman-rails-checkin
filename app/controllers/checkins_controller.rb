class CheckinsController < ActionController::Base
  include UsersHelper

  before_filter :project_exists

  def index
    checkins = @project.checkins

    if params[:user_id]
      checkins = checkins.where(user_id: params[:user_id])
    end

    if params[:date]
      checkins = checkins.for_date(Date.parse(params[:date]))
    end

    render json: checkins, each_serializer: CheckinListSerializer
  end

  def show
    render json: @project.checkins.find(params[:id])
  end

  def destroy
    checkin = @project.checkins.find(params[:id])
    checkin.destroy
    render json: checkin
  end

  def update
    params[:checkin].delete(:user_id)
    params[:checkin].delete(:created_at)
    checkin = @project.checkins.find(params[:id])
    checkin.update_attributes(params[:checkin])
    render json: checkin
  end

  def create
    params[:checkin].delete(:user_id)
    params[:checkin].delete(:created_at)
    params[:checkin].delete(:project_id)
    checkin = current_user.checkins.build(params[:checkin])
    checkin.project_id = @project.id
    checkin.save
    render json: checkin
  end

  private

  def project_exists
    @project = Project.find params[:project_id]
  end
end
