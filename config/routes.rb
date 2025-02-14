Rails.application.routes.draw do
  resources :users, only: [:create]   # User registration route
  post '/login', to: 'sessions#create'  # Login route

  resources :books, only: [:index, :show, :create] do  
    post 'borrow', to: 'books#borrow'
    post 'return', to: 'books#return_book'
  end

  get 'profile', to: 'profiles#show'  
end
