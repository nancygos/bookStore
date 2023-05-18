Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # get 'books/index'

      resources :books, only: [:index, :new, :edit, :show, :destroy, :create, :update]
      # resources :users, only: [:login, :signup]
      post "users/login"
      post "users/signup"
    end
  end
  # root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end