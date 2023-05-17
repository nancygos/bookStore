Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # get 'books/index'
      # get 'books/new'
      # post 'books/new'
      # get 'books/edit'
      # get 'books/show'
      # post 'books/create'

      resources :books, only: [:index, :new, :edit, :show, :destroy, :create, :update]
    end
  end
  # root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
