Rails.application.routes.draw do
  resources :users
  resources :user_sessions, only: [:new, :create]
  
  resources :todo_lists do
    resources :todo_items do
      member do
        patch :complete
      end
    end
  end
  root 'todo_lists#index'
end