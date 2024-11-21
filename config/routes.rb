Rails.application.routes.draw do
  devise_for :admins, skip: [ :registrations ]
  # Route này sẽ tạo đường dẫn users/:user_id/posts để hiển thị các bài đăng của user.
  resources :posts do
    resources :comments, only: [ :create, :destroy ]
  end
  resources :categories, only: [ :show ]
  namespace :api do
    resources :likes, only: [ :create, :destroy ]
  end
  resources :profiles, only: [ :show, :edit, :update ]

  authenticated :admin do
    root to: "admin#index", as: :admin_root
  end
  devise_for :users
  namespace :admin do
    resources :users
    resources :posts
  end
  # show lists posts of user
  # resources :users do
  #   get "posts", to: "user_posts#index", as: "posts" # Đường dẫn: /users/:user_id/posts
  # end

  get "up" => "rails/health#show", as: :rails_health_check


  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "admin" => "admin#index"

  root to: "posts#index"
end
