Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
# ユーザーに関するルーティング
  devise_scope :admin do
    root "projects#introduction"
    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations',
    invitations: 'admins/invitations',
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }
  resources :users, only: [:show]
  resources :admins, only: [:show]
# プロジェクトに関するルーティング
  resources :projects, except: [:show] do
    get :introduction, on: :collection
    get :project_launch, on: :member
    resources :subjects, shallow: true do
      resources :parts, except: [:index], shallow: true do
        patch :toggle_status
        resources :questions, shallow: true do
          resources :comments, shallow: true
        end
      end
    end
  end
  resources :parts, only: [:index]
  resources :questions, only: [:user_question, :index] do
    get :user_question, on: :collection
  end
  resources :project_users, only: [:create, :destroy]
  resources :project_admins, only: [:create, :destroy]
end
