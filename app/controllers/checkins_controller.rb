class CheckinsController < ApplicationController
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
    checkin = Checkin.find(params[:id])
    checkin.update_attributes(params[:checkin])
    render json: checkin
  end

  def create
    checkin = Checkin.new(params[:checkin])
    checkin.save
    render json: checkin
  end
end
