module Optim
  class Optimizables < API
    get '/optimizables' do
      authenticate
      current_project.optimizables.all
    end

    params do
      requires :reference_id, type: String, desc: "Reference ID"
      requires :class_name, type: String
      requires :optimizable_variants_attributes, type: Array do
        requires :url, type: String
      end
      optional :description, type: String, desc: "Description"
    end
    post '/optimizables' do
      authenticate
      @optimizable_class = current_project.optimizable_classes.find_or_initialize_by(:name => declared(params)[:class_name])
      @optimizable = Optimizable.new(declared(params).except(:class_name))
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