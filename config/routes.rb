Rails.application.routes.draw do

  root "fines#index"


  resources :fine_points
  resources :fines do
    post :identified_unidentified
  end
  resources :companies
  resources :cars do
    post :enable_disable
    end
  resources :car_models
  resources :car_types
  resources :users do
    post :enable_disable
  end


  devise_for :users, path: ""  # path pra nao dar conflito nas portas com gem devise
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
