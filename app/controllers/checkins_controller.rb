class CheckinsController < ActionController::Base
  include UsersHelper

  def index
    render json: Checkin.all, each_serializer: CheckinListSerializer
  end

  def show
    render json: Checkin.find(params[:id])
  end

  def destroy
    checkin = Checkin.find(params[:id])
    checkin.destroy
    render json: checkin
  end

  def update
    params[:checkin].delete(:user_id)
    params[:checkin].delete(:created_at)
    checkin = Checkin.find(params[:id])
    checkin.update_attributes(params[:checkin])
    render json: checkin
  end

  def create
    params[:checkin].delete(:user_id)
    params[:checkin].delete(:created_at)
    checkin = current_user.checkins.build(params[:checkin])
    checkin.save
    render json: checkin
  end
end
