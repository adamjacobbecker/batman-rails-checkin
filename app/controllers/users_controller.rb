class UsersController < ActionController::Base
  include UsersHelper

  def current
    if signed_in?
      render json: current_user, serializer: UserListSerializer, root: "user"
    else
      render json: {status: "not logged in"}, status: 401
    end
  end

  def index
    render json: User.all, each_serializer: UserListSerializer
  end

  def show
    user = User.find params[:id]
    render json: user
  end

  # used for logging in *and* account creation
  def create
    user = User.find_by_email(params[:user][:email].downcase)

    if !user # sign up
      user = User.new(params[:user])

      if user.save
        sign_in user
      else
        user = []
      end

    else # login
      if user.authenticate(params[:user][:password])
        sign_in user
      else
        user = []
      end
    end

    render json: user
  end

  def destroy
    sign_out
    render json: {status: "signed out"}
  end
end
