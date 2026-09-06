Rails.application.routes.draw do

  # http://localhost:3000/api/v1/short_urls
  namespace :v1 do
    # get 'order_items/index'
    post 'order_items/create', to: 'order_items#create'
    resources :order_items , only: [:index, :new, :edit, :show, :update, :destroy]

    # delete 'carts/:id', to: 'carts#destroy'
    get 'carts/checkout/:id', to: 'carts#checkout'
    resources :carts, only: [:index, :new, :edit, :show, :create, :update, :destroy]

    # books routes
    resources :books, only: [:index, :new, :edit, :show, :destroy, :create, :update]
    
    # users routes
    get "users/login"
    get "users/logout"
    post "users/signup"
    get "books/best_seller_books"

    # short urls routes
    resources :short_urls, only: [:index, :create, :show, :destroy]
  end
  
  # short url redirect routes
  get "nancy/:short_code", to: "short_urls#show", as: :nancy_short_url

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end