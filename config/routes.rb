Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'order_items/index'
      get 'order_items/new'
      get 'order_items/show'
      get 'order_items/edit'
    end
  end
  namespace :api do
    namespace :v1 do
      # get 'carts/index'
      delete 'carts/:id', to: 'carts#destroy'
      resources :carts, only: [:index, :new, :edit, :show, :create, :update]
    end
  end
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :new, :edit, :show, :destroy, :create, :update]
      
      get "users/login"
      get "users/logout"
      post "users/signup"

    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end