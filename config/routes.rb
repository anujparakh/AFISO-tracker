Rails.application.routes.draw do

  resources :payments do
    member do
      get :delete
    end
  end

  resources :semesters do
	  member do
		  get :delete
	  end
  end

  resources :members do
	  member do
		  get :delete
	  end
  end

  resources :transactions do
    member do
      get :delete
    end
  end

  # root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  root to: "home#index"
  get 'home/index'
  get 'home/help'
  get 'home/settings'

  post 'officers/create' => 'officers#create', as: :create_officer
  delete 'officers/destroy/:id' => 'officers#destroy', as: :destroy_officer

  # mount Lockup::Engine, at: '/lockup'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



end
