class InviteesController < ActionController::Base
  include UsersHelper

  before_filter :project_exists

  def index
    render json: @project.invitees.all
  end

  def destroy
    invitee = @project.invitees.find(params[:id])
    invitee.destroy
    render json: invitee
  end

  private

  def project_exists
    @project = Project.find params[:project_id]
  end
end
