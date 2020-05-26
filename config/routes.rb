Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
# ユーザーに関するルーティング
  root 'projects#introduction'
  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
  end
  devise_scope :user do
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
  resources :users, only: [:index, :show, :destroy]
  resources :admins, only: [:index, :show, :destroy]
# プロジェクトに関するルーティング
  resources :questions, only: [:my_question_index, :index] do
    get :my_question_index, on: :collection, as: :self
  end
  resources :projects, except: [:show] do
    get :introduction, on: :collection
    get :project_launch, on: :member
    resources :categories, shallow: true
    resources :tests, shallow: true do
      get :active, on: :collection
      patch :toggle_active
      get :entry, on: :member
      post :update_row_order, on: :collection
      resources :test_questions, shallow: true do
        post :update_row_order, on: :collection
      end
    end
    resources :subjects, shallow: true do
      post :update_row_order, on: :collection
      resources :parts, except: [:index, :update_row_order], shallow: true do
        resources :questions, shallow: true do
          resources :comments, shallow: true
        end
      end
    end
  end
  resources :parts, only: [:index, :update_row_order] do
    post :update_row_order, on: :collection
  end
  resources :user_participations, only: [:create, :destroy]
  resources :admin_participations, only: [:create, :destroy]
  resources :admin_choice_categories, only: [:create, :destroy]
  resources :user_choice_categories, only: [:create, :destroy]
  resources :achieveds, only: [:create, :destroy]
  resources :user_answers do
    get :check, on: :collection
  end
end
