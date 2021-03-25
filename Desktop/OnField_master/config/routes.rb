Rails.application.routes.draw do

  root 'posts#calender'

  # devise
  devise_for :users, :controllers => {sessions: 'users/sessions', registrations: 'users/registrations'}
  resources :users

  devise_scope :user do
    get 'users/solo_users' => 'users/registrations#solo_users'
  end

  def devise_scope(scope)
    constraint = lambda do |request|
      request.env["devise.mapping"] = Devise.mappings[scope]
      true
    end

    constraints(constraint) do
      yield
    end

  end

  # 投稿
  get 'posts/comp'
  get 'posts/back'
  get 'posts/details/:id', to: 'posts#details'
  get 'posts/calender/:start_time', to: 'posts#show'
  resources :posts

  resources :posts do
    member do
      get 'take'
      get 'cancel'
    end
  end
  
  # チャット
  resources :rooms

  # 個人情報
  get 'solo_users/comp'
  get 'solo_users/back'
  resources :solo_users

  # チーム情報
  get 'teams/comp'
  get 'teams/back'
  resources :teams

  # コメント機能
  resources :posts do
    resources :comments, only: [:create]
  end

end
