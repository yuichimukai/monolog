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
				sessions: 'users/sessions',
		           }
		devise_scope :user do
			get 'sign_in', to: 'users/sessions#new'
			get 'sign_out', to: 'users/sessions#destroy'
		end
		resources :users do
			member { get :following, :followers }
		end
		resources :microposts do
			resources :likes, only: %i[create destroy]
		end
		resources :relationships, only: %i[create destroy]
	end
