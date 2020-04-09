Rails.application.routes.draw do
  get '/heartbeat', to: lambda {|_| [200, { 'Content-Type' => 'application/json' }, [{ status: "ok" }.to_json] ] }
  root to: lambda {|_| [200, { 'Content-Type' => 'application/json' }, [{ status: "ok" }.to_json] ] }
  
  devise_for :users, skip: %i[registrations sessions passwords invitations]
  devise_for :users, controllers: { invitations: 'invitations' }
  devise_scope :user do
    post '/users', to: 'registrations#create'
    post '/token', to: 'sessions#create'
    delete '/token', to: 'sessions#destroy'
    post '/passwords', to: 'passwords#create'
    patch '/passwords', to: 'passwords#update'
  end

  resources :languages, only: %i[index]
  resources :kits, only: %i[index show create update destroy] do
    resources :kit_videos
    resources :outcomes
  end
  resources :users, only: %i[show update destroy] do
    member do
      post :verify_school_code
      post :resend_school_code
      post :join_school
      patch :update_invitation
    end
    collection do
      get :invited_users
    end
  end
  resources :tickets, only: %i[index create]
  resource :payment_profile, only: %i[update show]
  resources :user_kits, only: %i[index create]
  resources :grades, only: %i[index create show] do
    member do
      get :learning_paths
    end
  end
  resources :grade_learning_paths, only: %i[create]
  resources :learning_paths, only: %i[index] do
    member do
      get :grades
    end
    resources :chapters, only: %i[index create show destroy]
  end
  resources :user_learning_paths, only: %i[index create]
  resources :teacher_programs, only: %i[index]
  resources :teacher_voicepacks, only: %i[index]
  resources :teacher_videos, only: %i[index]
  resources :subscriptions, only: %i[create destroy]
end
