class ProjectsController < ActionController::Base
  include UsersHelper

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
    project = current_user.projects.find params[:id]
    project.update_attributes params[:project]
    render json: project
  end

  def show
    project = current_user.projects.find params[:id]
    render json: project
  end

  def destroy
    project = current_user.projects.find params[:id]
    project.destroy
    render json: project
  end

end
