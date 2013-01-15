class UsersController < ActionController::Base
  def current
    if signed_in?
      render json: current_user
    else
      render json: {status: "not logged in"}, status: 401
    end
  end

  def index
    render json: User.all
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


  private

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !current_user.nil?
  end
end
