Rails.application.routes.draw do
  resources :events do
    post :accept, on: :member
  end

  devise_for :users
  
  root 'events#index'
end
