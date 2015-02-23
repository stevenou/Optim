class OptimizablesController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_optimizable_class
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  def new
    @optimizable = @optimizable_class.optimizables.new
    authorize @optimizable
  end

  def create
    @optimizable = @optimizable_class.optimizables.new(optimizable_params)
    authorize @optimizable

    if @optimizable.save
      flash[:notice] = "#{@optimizable.optimizable_class.name} #{@optimizable.reference_id} successfully created."
      redirect_to optimizable_class_path(@optimizable_class)
    else
      render :new
    end
  end

  def show
    @optimizable = Optimizable.find(params[:id])
    authorize @optimizable
    deduce_project
  end

  def edit
    @optimizable = Optimizable.find(params[:id])
    authorize @optimizable
    deduce_project
  end

  def update
    @optimizable = Optimizable.find(params[:id])
    authorize @optimizable

    if @optimizable.update_attributes(optimizable_params)
      flash[:notice] = "#{@optimizable.optimizable_class.name} #{@optimizable.reference_id} successfully updated."
      redirect_to optimizable_class_path(@optimizable.optimizable_class)
    else
      render :edit
    end
  end

  def destroy
    @optimizable = Optimizable.find(params[:id])
    authorize(@optimizable)

    if @optimizable.destroy
      flash[:notice] = "#{@optimizable.optimizable_class.name} #{@optimizable.reference_id} successfully deleted."
    else
      flash[:error] = "An error occurred while attempting to delete the #{@optimizable.optimizable_class.name} #{@optimizable.reference_id}. "
    end

    redirect_to :back
  end

  protected
  def optimizable_params
    params.require(:optimizable).permit(:reference_id, :description, :optimizable_variants_attributes => [:url])
  end

  def deduce_project
    @project = @optimizable ? @optimizable.optimizable_class.project : nil
  end
end
