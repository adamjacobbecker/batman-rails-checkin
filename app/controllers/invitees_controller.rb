class InviteesController < BaseActionController
  before_filter :project_exists

  def index
    render json: @project.invitees.all
  end

  def destroy
    invitee = @project.invitees.find(params[:id])
    invitee.destroy
    render json: invitee
  end
end
