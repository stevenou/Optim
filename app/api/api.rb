class API < Grape::API
  version 'v1', using: :path
  format :json

  helpers do
    def authenticated
      return true if current_project
    end

    def current_project
      Project.find_by_api_key(headers["Api-Token"])
    end

    def authenticate
      error!("401 Unauthorized", 401) unless authenticated
    end
  end

  mount Optim::Optimizables
end