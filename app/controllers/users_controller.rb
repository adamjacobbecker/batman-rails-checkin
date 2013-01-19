class UsersController < ActionController::Base
  include UsersHelper

  before_filter :project_exists, only: [:index, :show]

  def current
    if signed_in?
      render json: current_user, serializer: UserListSerializer, root: "user"
    else
      render json: {status: "not logged in"}, status: 401
    end
  end

  def index
    render json: User.all, each_serializer: UserListSerializer, root: "user", project_id: @project.id
  end

  def show
    user = User.find params[:id]
    render json: user, serializer: UserListSerializer, project_id: @project.id
  end

  def oauth
    require 'oauth2'

    client = OAuth2::Client.new(ENV['GITHUB_ID'],
                                ENV['GITHUB_SECRET'],
                                authorize_url: 'https://github.com/login/oauth/authorize',
                                token_url: 'https://github.com/login/oauth/access_token')

    return redirect_to client.auth_code.authorize_url(redirect_uri: '') unless params[:code]

    token = client.auth_code.get_token(params[:code], redirect_uri: '')

    response = HTTParty.get("https://api.github.com/user?access_token=#{token.token}")

    user = User.where(login: response["login"], access_token: token.token).first_or_create!(
      name: response["name"],
      email: response["email"]
    )

    sign_in(user)

    redirect_to "/"
  end

  def destroy
    sign_out
    render json: {status: "signed out"}
  end

  private

  def project_exists
    @project = Project.find params[:project_id]
  end
end
