Rails.application.routes.draw do
  get "books/index"
  get "books/show"
  root "books#index"

  # Authentication routes
  get "signup", to: "registrations#new"
  post "signup", to: "registrations#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Book and borrowing routes
  resources :books, only: [:index, :show] do
    post "borrow", on: :member
    post "return", on: :member
  end
  resources :borrowings, only: [:index]
end
