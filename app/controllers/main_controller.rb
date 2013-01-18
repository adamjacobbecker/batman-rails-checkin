class MainController < ActionController::Base
  include UsersHelper

  def index
    @user_json = UserSerializer.new(current_user).to_json
  end
end
