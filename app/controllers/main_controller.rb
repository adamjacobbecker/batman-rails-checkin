class MainController < ActionController::Base
  include UsersHelper

  def index
    @user_json = UserListSerializer.new(current_user).to_json
  end
end
