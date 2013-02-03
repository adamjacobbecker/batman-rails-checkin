class ProjectsController < BaseActionController
  before_filter :logged_in

  before_filter :project_exists, only: [:update, :show, :destroy]

  before_filter :i_am_project_owner, only: :destroy

  def index
    render json: current_user.projects.all
  end

  def create
    project = Project.new(name: params[:project][:name])
    project.owner = current_user
    project.users << current_user
    project.save
    render json: project
  end

  def update
    params[:project].delete("owner_id")
    @project.update_attributes params[:project]
    render json: @project
  end

  def show
    render json: @project
  end

  def destroy
    @project.destroy
    render json: @project
  end

  private

  def project_exists
    @project = current_user.projects.find params[:id]
  end

  def i_am_project_owner
    return unauthorized unless @project.owner == current_user
  end
end
