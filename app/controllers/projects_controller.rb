class ProjectsController < ActionController::Base
  include UsersHelper

  def index
    render json: current_user.projects.all
  end

  def create
    project = Project.create(name: params[:project][:name])
    project.users << current_user
    render json: project
  end

  def show
    project = current_user.projects.find params[:id]
    render json: project
  end
end
