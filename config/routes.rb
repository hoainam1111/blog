Rails.application.routes.draw do
  # Route này sẽ tạo đường dẫn users/:user_id/posts để hiển thị các bài đăng của user.

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
  end
  resources :categories, only: [ :show ]
  namespace :api do
    resources :likes, only: [ :create, :destroy ]
  end
  resources :profiles, only: [ :show, :edit, :update ]

  devise_for :users

  # show lists posts of user
  resources :users do
    get "posts", to: "user_posts#index", as: "posts" # Đường dẫn: /users/:user_id/posts
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  root to: "posts#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
