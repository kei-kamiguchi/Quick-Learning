Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_scope :admin do
    root "admins/sessions#new"
  end
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations',
    invitations: 'admins/invitations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }
  resources :users, only: [:show]
  resources :admins, only: [:show]
  resources :parts
  resources :subjects
  resources :projects do
    get :introduction, on: :member
  end
  resources :questions
  resources :project_users, only: [:create, :destroy]
end
