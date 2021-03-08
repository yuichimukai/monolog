Rails.application.routes.draw do
  get 'users/show'
    root 'static_pages#home'
    get 'static_pages/home'
    get 'static_pages/help'
    get 'users/show' => "users#show"
    devise_for :users,
                controllers: {
                registrations: 'users/registrations',
                sessions: 'users/sessions'
              }

    devise_scope :user do
      get 'sign_in', to: 'users/sessions#new'
      get 'sign_out', to: 'users/sessions#destroy'
    end
end
