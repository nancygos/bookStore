Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :new, :edit, :show, :destroy, :create, :update]
      # resources :users, only: [:login, :signup]
      post "users/login"
      get "users/logout"
      post "users/signup"

    end
  end

  # get 'books/index'
  # root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end