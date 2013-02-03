class BaseActionController < ActionController::Base
  include UsersHelper

  private

  def logged_in
    return unauthorized unless signed_in?
  end

  def project_exists
    @project = current_user.projects.find params[:project_id]
  end

  def unauthorized
    render json: {status: "unauthorized"}, status: 401
  end
end
