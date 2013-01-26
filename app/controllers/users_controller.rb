class UsersController < BaseActionController

  before_filter :project_exists, only: [:index, :show, :create]

  def current
    if signed_in?
      render json: current_user, serializer: UserSerializer, root: "user"
    else
      render json: {status: "not logged in"}, status: 401
    end
  end

  def update
    user = current_user
    user.update_attributes(params[:user])
    render json: user
  end

  def index
    render json: @project.users.all, each_serializer: UserListSerializer, root: "users", project_id: @project.id
  end

  def show
    user = @project.users.find params[:id].split("_")[0]
    render json: user, serializer: UserDetailsSerializer, project_id: @project.id, root: "user"
  end

  def create
    user = User.find_by_email(params[:user][:email])

    if user
      @project.users << user
      render json: user, serializer: UserDetailsSerializer, project_id: @project.id, root: "user"
    else
      invitee = Invitee.create email: params[:user][:email].downcase, project_id: @project.id
      Thread.new do
        UserMailer.invite_email(params[:user][:email], current_user, invitee.invite_code, @project).deliver
      end
      render json: []
    end
  end

  def oauth
    require 'oauth2'

    client = OAuth2::Client.new(ENV['GITHUB_ID'],
                                ENV['GITHUB_SECRET'],
                                authorize_url: 'https://github.com/login/oauth/authorize',
                                token_url: 'https://github.com/login/oauth/access_token')

    return redirect_to client.auth_code.authorize_url(redirect_uri: '', state: params[:invite]) unless params[:code]

    invite_code = params[:state]
    invited_email = Invite.where(invite_code: invite_code).email

    token = client.auth_code.get_token(params[:code], redirect_uri: '')

    response = HTTParty.get("https://api.github.com/user?access_token=#{token.token}")


    user = User.where(login: response["login"], access_token: token.token).first_or_create!(
      name: response["name"] && !response["name"].blank? ? response["name"] : response["login"],
      email: response["email"] && !response["email"].blank? ? response["email"] : invited_email
    )

    Invitee.associate_invites_with_user_by_email(user)
    Invitee.associate_invites_with_user_by_invite_code(user, invite_code)

    sign_in(user)

    redirect_to "/"
  end

  def destroy
    sign_out
    render json: {status: "signed out"}
  end

  def typeahead
    render json: User.where("email LIKE :query", query: "%#{params[:query]}%").pluck("email")
  end
end
