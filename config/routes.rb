Rails
	.application
	.routes
	.draw do
		root 'static_pages#home'
		get 'static_pages/home'
		get 'static_pages/help'
		devise_for :users,
		           controllers: {
				registrations: 'users/registrations',
				passwords: 'users/passwords',
				sessions: 'users/sessions',
		           }
		devise_scope :user do
			post 'users/guest_sign_in', to: 'users/sessions#new_guest'
			get 'sign_in', to: 'users/sessions#new'
			get 'sign_out', to: 'users/sessions#destroy'
		end
		resources :users do
			member { get :following, :followers }
		end
		resources :microposts do
			resources :comments, only: %i[create destroy]
		end
		post 'like/:id' => 'likes#create', :as => 'create_like'
		delete 'like/:id' => 'likes#destroy', :as => 'destroy_like'
		resources :relationships, only: %i[create destroy]
		resources :chat_rooms, only: %i[create show]
		resources :notifications, only: :index
	end
