module Optim
  class Optimizables < API
    get '/optimizables' do
      authenticate
      current_project.optimizables.all
    end

    params do
      requires :reference_id, type: String, desc: "Reference ID", allow_blank: false
      requires :optimizable_class, type: Hash do
        optional :name, type: String, allow_blank: false
        optional :id, type: Integer, allow_blank: false
        exactly_one_of :name, :id
      end
      requires :optimizable_variants_attributes, type: Array do
        requires :url, type: String, allow_blank: false
      end
      optional :description, type: String, desc: "Description"
    end
    post '/optimizables' do
      authenticate
      Rails.logger.info(params)
      Rails.logger.info(declared(params))
      declared_params = declared(params)
      if declared_params[:optimizable_class][:name]
        @optimizable_class = current_project.optimizable_classes.find_or_initialize_by(:name => declared_params[:optimizable_class][:name])
      elsif declared_params[:optimizable_class][:id]
        @optimizable_class = current_project.optimizable_classes.find(declared_params[:optimizable_class][:id])
      end
      @optimizable = Optimizable.new(declared_params.except(:optimizable_class))
      @optimizable.optimizable_class = @optimizable_class
      if @optimizable.save
        @optimizable
      else
        error!(@optimizable.errors, 500)
      end
    end

    get '/optimizables/:id' do
      Optimizable.find(params[:id])
    end
  end
end