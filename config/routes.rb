Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
# ユーザーに関するルーティング
  root 'admin_participations#new'
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
  resources :admins, only: [:index, :show, :destroy, :toggle_admin] do
    patch :toggle_admin
  end
# プロジェクトに関するルーティング
  resources :projects, except: [:show, :edit] do
    resources :categories, shallow: true
    resources :tests, shallow: true do
      patch :toggle_active
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
  resources :questions, only: [:index]
  resources :self_questions, only: [:index]
  resources :user_participations, only: [:new, :create]
  resources :admin_participations, only: [:new, :create]
  resources :admin_choice_categories, only: [:create, :destroy]
  resources :user_choice_categories, only: [:create, :destroy]
  resources :achieveds, only: [:create, :destroy]
  resources :answer_papers do
    get :check, on: :collection
    patch :toggle_edit
    patch :toggle_checked
    patch :back, on: :collection
  end
  resources :backed_answer_papers do
    get :check, on: :collection
  end
  resources :testings, only: [:index, :show, :create, :new]
end
