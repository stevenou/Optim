Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  mount API => '/api'

  root to: 'visitors#index'
  devise_for :users
  resources :companies, :shallow => true do
    resources :projects do
      resources :optimizable_classes do
        resources :optimizables do
          resources :optimizable_variants
        end
      end
    end
  end
end
