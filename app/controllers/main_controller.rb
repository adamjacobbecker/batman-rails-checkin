class MainController < BaseActionController
  def index
    @user_json = if current_user
      UserListSerializer.new(current_user).to_json
    else
      {}
    end
  end
end
