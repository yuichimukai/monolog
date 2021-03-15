Rails
	.application
	.routes
	.draw do
		root 'static_pages#home'
		get 'static_pages/home'
		get 'static_pages/help'
		resources :users, only: %i[show edit]
		devise_for :users,
		           controllers: {
				registrations: 'users/registrations',
				sessions: 'users/sessions',
		           }

		devise_scope :user do
			get 'sign_in', to: 'users/sessions#new'
			get 'sign_out', to: 'users/sessions#destroy'
			get 'edit', to: 'users/registrations#edit'
		end
	end
