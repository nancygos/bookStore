Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # get 'order_items/index'
      resources :order_items , only: [:index, :new, :edit, :show, :create, :update, :destroy]
    end
  end
  namespace :api do
    namespace :v1 do
      # delete 'carts/:id', to: 'carts#destroy'
      resources :carts, only: [:index, :new, :edit, :show, :create, :update, :destroy]
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