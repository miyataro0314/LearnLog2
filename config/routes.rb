Rails.application.routes.draw do
  root to: 'static_pages#top'
  get 'dashboard', to: 'static_pages#dashboard', as: :dashboard

  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  post 'logs/start', to: 'logs#start', as: :start_log
  post 'logs/end', to: 'logs#end', as: :end_log
  get 'logs/search', to: 'logs#search_logs', as: :search_logs

  get 'dailynotes/search', to: 'daily_notes#search_daily_notes', as: :search_daily_notes

  resources :users, only: %i[new create destroy]
  resources :logs, only: %i[new index show edit update destroy]
  resources :daily_notes, only: %i[new create index show edit update]
  resources :mantras, only: %i[new index edit create update destroy]

  resource :profile, only: %i[show edit update destroy]
  
  get "up" => "rails/health#show", as: :rails_health_check
end
