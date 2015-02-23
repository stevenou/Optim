class OptimizableClassesController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_project
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  def new
    @optimizable_class = @project.optimizable_classes.new
    authorize @optimizable_class
  end

  def create
    @optimizable_class = @project.optimizable_classes.new(optimizable_class_params)
    authorize @optimizable_class

    if @optimizable_class.save
      flash[:notice] = "#{@optimizable_class.name} category successfully created."
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @optimizable_class = OptimizableClass.find(params[:id])
    authorize @optimizable_class
    deduce_project
  end

  def destroy
    @optimizable_class = OptimizableClass.find(params[:id])
    authorize(@optimizable_class)

    if @optimizable_class.destroy
      flash[:notice] = "#{@optimizable_class.name} category successfully deleted."
    else
      flash[:error] = "An error occurred while attempting to delete the #{@optimizable_class.name} category. "
    end

    redirect_to :back
  end

  protected
  def optimizable_class_params
    params.require(:optimizable_class).permit(:name)
  end

  def deduce_project
    @project = @optimizable_class ? @optimizable_class.project : nil
  end
end
