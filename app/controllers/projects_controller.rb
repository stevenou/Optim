class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_company
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  def new
    @project = @company.projects.new
    authorize @project
  end

  def create
    @project = @company.projects.new(project_params)
    @project.users << current_user
    authorize @project

    if @project.save
      flash[:notice] = "#{@project.name} project successfully created."
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  protected
  def project_params
    params.require(:project).permit(:name, :subdomain)
  end
end
