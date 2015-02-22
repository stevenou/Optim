class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_company

  def new
    @project = @company.projects.new
  end

  def create
    @project = @company.projects.new(project_params)
    @project.users << current_user

    if @project.save
      flash[:notice] = "#{@project.name} project successfully created."
      redirect_to company_project_path(@company, @project)
    else
      render :new
    end
  end

  def show
    @project = @company.projects.find(params[:id])
  end

  protected
  def project_params
    params.require(:project).permit(:name, :subdomain)
  end
end
