class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_company
  after_action :verify_policy_scoped, :only => :index
  after_action :verify_authorized, :except => :index

  def edit

  end

  def update

  end
end
