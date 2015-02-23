class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def find_company
    if params[:company_id].present?
      @company = Company.find(params[:company_id])
    end
  end

  def find_project
    if params[:project_id].present?
      @project = Project.find(params[:project_id])
    end
  end

  def find_optimizable_class
    if params[:optimizable_class_id].present?
      @optimizable_class = OptimizableClass.find(params[:optimizable_class_id])
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name, :companies_attributes => [:name])
  end
end
