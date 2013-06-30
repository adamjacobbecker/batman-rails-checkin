class CheckinsController < BaseActionController
  before_filter :logged_in

  before_filter :project_exists

  before_filter :checkin_exists_and_is_mine, only: [:destroy, :update]

  def index
    checkins = @project.checkins

    if params[:user_id]
      user_id = params[:user_id].split("_")[0]
      checkins = checkins.where(user_id: user_id)
    end

    if params[:date]
      checkins = checkins.for_date(Date.parse(params[:date]))
    end

    pagination_info = {
      total: checkins.count,
      per_page: !params[:per_page].blank? ? params[:per_page].to_i : 10,
      page: !params[:page].blank? ? params[:page].to_i : 1
    }

    checkins = checkins.limit(pagination_info[:per_page]).offset((pagination_info[:page] - 1)*pagination_info[:per_page])

    render json: checkins, each_serializer: CheckinListSerializer, meta: pagination_info
  end

  def show
    render json: @project.checkins.find(params[:id])
  end

  def destroy
    @checkin.destroy
    render json: @checkin
  end

  def update
    params[:checkin].delete(:user_id)
    params[:checkin].delete(:created_at)
    @checkin.update_attributes(params[:checkin])
    render json: @checkin
  end

  def create
    params[:checkin].delete(:user_id)
    params[:checkin].delete(:created_at)
    params[:checkin].delete(:project_id)
    checkin = current_user.checkins.build(params[:checkin])
    checkin.project_id = @project.id
    checkin.save

    Thread.new do
      if @project.campfire_subdomain && @project.campfire_token && @project.campfire_room
        campfire = Tinder::Campfire.new @project.campfire_subdomain, token: @project.campfire_token
        room = campfire.find_room_by_name @project.campfire_room
        room.speak "#{checkin.user.name} checked in!"
        room.paste checkin.body
      end

      if @project.hipchat_token
        client = HipChat::Client.new(@project.hipchat_token)
        icon = ([['(yodawg)', '(trump)', '(romney)', '(rebeccablack)', '(kwanzaa)'].sample] * 3).join(' ')
        client[@project.hipchat_room].send('MorningCheckin', "#{checkin.user.name} checked in! #{icon}", message_format: :text)
        client[@project.hipchat_room].send('MorningCheckin', checkin.body, message_format: :text)
      end
    end

    render json: checkin
  end

  private

  def checkin_exists_and_is_mine
    @checkin = @project.checkins.find(params[:id])
    return unauthorized unless @checkin.user == current_user
  end
end