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
      @optimizable = current_project.optimizables.new(declared(params))
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